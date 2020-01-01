## [ATN](https://atn.io/) 抵御合约攻击的报告

### 基于ERC223与DS-AUTH的混合漏洞

2018年5月11日中午，ATN技术人员收到异常监控报告，显示ATN Token供应量出现异常，迅速介入后发现Token合约由于存在漏洞受到攻击。本报告描述黑客的攻击操作、利用的合约漏洞以及ATN的应对追踪方法。

#### 攻击：

1.  黑客利用ERC223方法漏洞，获得提权，将自己的地址设为owner

    [https://etherscan.io/tx/0x3b7bd618c49e693c92b2d6bfb3a5adeae498d9d170c15fcc79dd374166d28b7b](https://etherscan.io/tx/0x3b7bd618c49e693c92b2d6bfb3a5adeae498d9d170c15fcc79dd374166d28b7b)

2.  黑客在获得owner权限后，发行1100w ATN到自己的攻击主地址

    [https://etherscan.io/tx/0x9b559ffae76d4b75d2f21bd643d44d1b96ee013c79918511e3127664f8f7a910](https://etherscan.io/tx/0x9b559ffae76d4b75d2f21bd643d44d1b96ee013c79918511e3127664f8f7a910)

3.  黑客将owner设置恢复，企图隐藏踪迹

    [https://etherscan.io/tx/0xfd5c2180f002539cd636132f1baae0e318d8f1162fb62fb5e3493788a034545a](https://etherscan.io/tx/0xfd5c2180f002539cd636132f1baae0e318d8f1162fb62fb5e3493788a034545a)

4.  黑客从主地址将偷来的黑币分散到14个地址中

```
    0x54868268e975f3989d77e0a67c943a5e65ed4a73 3411558.258
    0x62892fd48fd4b2bbf86b75fc4def0a37b224fcc1 946828.3
    0x57be7b4d3e1c6684dac6de664b7809185c8fc356 929,995.9
    0x3b361e253c41897d78902ce5f7e1677fd01083da 838,991
    0x7279e64d3ae20745b150e330fc080050deebeb4d 784,409.41
    0xb729eac33217c0b28251261194d79edd89d18292 762,518.6
    0xe67dc4b47e0ac9b649e52cdb883370d348871d64 682,026.9
    0x44660bae953555ccfdcc5a38c78a5a568b672daa 564,288
    0xf7e915e7ec24818f15c11ec74f7b8d4a604d7538 551,018.8
    0xa4b45e8cca78e862d3729f10f4998da4200f10ef 438,277.6
    0xc98e179f2909b1d0bce5b5d22c92bf803fc0d559 350,597.35
    0xd5f898c7914e05ec7eaa3bf67aafd544a5bb5f24 325,291.1
    0x3dd815af5d728903367a3036bc6dbe291de6f0ee 282,069.29
    0x6d8750f28fffb8e9920490edb4ed1817a4736998 110,261.2948`</pre>
```

利用的合约漏洞：

ATN Token合约采用的是在传统ERC20Token合约基础上的扩展版本[ERC223](https://github.com/ethereum/EIPs/issues/223 "ERC223")，并在其中使用了 [dapphub/ds-auth](https://github.com/dapphub/ds-auth "dapphub/ds-auth") 库。采用这样的设计是为了实现以下几个能力：

*  天然支持Token互换协议，即ERC20Token与ERC20Token之间的直接互换。本质上是发送ATN时，通过回调函数执行额外指令，比如发回其他Token。
*  可扩展的、结构化的权限控制能力。
*  Token合约可升级，在出现意外状况时可进行治理。

单独使用 ERC223 或者 ds-auth 库时，并没有什么问题，但是两者结合时，黑客利用了回调函数回调了setOwner方法，从而获得高级权限。

[ERC223转账](https://github.com/ATNIO/atn-contracts/blob/7203781ad8d106ec6d1f9ca8305e76dd1274b181/src/ATN.sol#L100 "ERC223转账")代码如下：

```javascript
  function transferFrom(address _from, address _to, uint256 _amount,
  bytes _data, string _custom_fallback) public returns (bool success)
  {
  ...
  ERC223ReceivingContract receiver =
  ERC223ReceivingContract(_to);
  receiving.call.value(0)(byte4(keccak256(_custom_fallback)), _from, amout, data);
  ...
  }
```

当黑客[转账](https://etherscan.io/tx/0x3b7bd618c49e693c92b2d6bfb3a5adeae498d9d170c15fcc79dd374166d28b7b "转账")时在方法中输入以下参数：

```javascript
transferFrom( hacker_address, atn_contract_address, 0, 0,
    "setOwner(address)")

    _from: 0x2eca25e9e19b31633db106341a1ba78accba7d0f -- 黑客地址
    _to: 0x461733c17b0755ca5649b6db08b3e213fcf22546 -- ATN合约地址
    _amount: 0
    _data: 0x0
    _custom_fallback: setOwner(address)
```

该交易执行的时候 receiver 会被 `_to(ATN合约地址)` 赋值， ATN 合约会调用 `_custom_fallback` 即 DSAuth 中的 setOwner(adddress) 方法，而此时的 msg.sender 变为 ATN 合约地址，`owner_`参数为`_from(黑客地址)`

ds-auth库中setOwner [代码](https://github.com/dapphub/ds-auth/blob/c0050bbb6807027c623b1a1ee7afd86515cdb004/src/auth.sol#L36 "代码")如下：

```javascript
functuin setOwner(address owner_) public auth
    {
    own = owner_;
    LogSetOwner(owner);
    }
```    

此时 setOwner 会先验证 auth 合法性的，而 msg.sender 就是ATN的合约地址。setOwner 的 modifier [auth](https://github.com/dapphub/ds-auth/blob/c0050bbb6807027c623b1a1ee7afd86515cdb004/src/auth.sol#L52 "auth") 代码如下：

```javascript
modifier auth {
    require(isAuthorized(msg.sender, msg.sig));
    _;
}
function isAuthorized(address src, bytes4 sig) internal view returns
(bool) {
  if (src == address(this)) { //此处的src与ATN合约地址一致返回true
return true;
} else { … }
```

通过利用这个ERC223方法与DS-AUTH库的混合漏洞，黑客将 ATN Token合约的 owner 变更为自己控制的地址。获取 owner 权限后，黑客发起[另外一笔交易](https://etherscan.io/tx/0x9b559ffae76d4b75d2f21bd643d44d1b96ee013c79918511e3127664f8f7a910 "另外一笔交易")对 ATN 合约进行攻击，调用 mint 方法给另外一个地址发行 1100wATN。

最后，黑客调用 setOwner 方法将[权限复原](https://etherscan.io/tx/0xfd5c2180f002539cd636132f1baae0e318d8f1162fb62fb5e3493788a034545a "权限复原")。

#### 漏洞评估：

漏洞等级：严重

产品影响：atn-contracts

可能损失：导致Token总供应量发生变化

发现了基于ERC223标准与dapphub/ds-auth库相结合的合约漏洞，更准确的说是在ERC223回调函数发起时，调用本身合约时可能造成内部权限控制失效。

#### 应对措施：

经过上面的追踪，发现黑客将黑币分散在14个不同的新地址中，而这些地址中并没有ETH，暂时不存在立即的转账到交易所销赃的风险。我方有能力立即冻结黑客的黑币，恢复供应量的变化，所以，重点在如何追踪到黑客，应对思路如下：

1.  准备修复措施，增加Guard合约禁止回调函数向ATN合约本身回调；增加黑名单合约，随时冻结黑客地址
2.  等待黑客向交易所发送充值交易，以便获得进一步证据
3.  获得证据后，立即启动修复流程，将黑客相关地址加入黑名单，禁止其转移ATN Token
4.  基金会销毁等量ATN Token以恢复供给总量，并在ATN主链上线时予以修正。

产品修复：新增Guard合约，禁止对ATN合约发送转账交易，进而防止回调函数对ATN合约进行方法调用。

![](https://images.seebug.org/content/images/2018/06/d8ea9310-e97f-4b77-9016-ad637f072b46.png-w331s)

<center>ATN整体关系图</center>

由于 ATN 合约的灵活性和治理扩展性，创建并添加了两个 Guard 合约。

1.  创建添加 [FrozenGuard](https://etherscan.io/tx/0xb486decc811ef9744af223222004adbe3869706eb3f0f8e8736ae306a4ec7d88 "FrozenGuard") 合约，禁止对 ATN 合约发送转账交易。
2.  创建添加 [StopTransferGuard](https://etherscan.io/tx/0xf1cbbbd0ecd0098ce49b25644885870fe704465373ffb20f6a3117ad44531eae "StopTransferGuard") 合约，冻结黑客账户地址，禁止其 ATN进行转账。
3.  基金会[销毁](https://etherscan.io/tx/0xd8bfe8948259a0de2d28d14c6e45bda41ea09dc557ef38765964d6816c6bea8a "销毁") 1100w ATN，恢复 ATN 总量。

    ATN Gurad 会在发生转账交易时，对交易的合法性进行处理。

    ATN 转账代码如下：

```javascript
function transferFrom(address _from, address _to, uint256 _amount,
    bytes _data, string _custom_fallback) public returns (bool success) {
    if (isContract(controller)) {
      if (!TokenController(controller).onTransfer(_from, _to, _amount))
        throw;
      }
     ...
    }
```

ATN 的 `TokenController` 接管了 `onTranser(_from, _to, amount)` 处理方法，实现对交易的合法性验证。具体方法在 SwapController 中[实现](https://github.com/ATNIO/atn-contracts/blob/7203781ad8d106ec6d1f9ca8305e76dd1274b181/src/SwapController.sol#L29 "实现")：

```javascript
function onTransfer(address _from,address _to, uint _amount) public
    returns (bool) {
    for (uint i =0; i&lt;guards.length; i++) {
     if (!gruards[i].onTokenTransfer(_from, _to, amount)) {
       return false;
     }
     }
    }
```

SwapController 中维护了 TokenTransferGuard 的合约列表，可以添加多个 Guard 合约对交易的合法性进行验证。

[FrozenGuard.sol](https://gist.github.com/HackFisher/ad2567bda8a082dd2e70ea86b427ee4d "FrozenGuard.sol") 代码如下：

```javascript
function onTokenTransfer(address _from, addres _to, uint _amount)
    public returns (bool) {
     if (_to == tokenAddress) {
       return false;
     }
     return true;
    }
```

tokenAddress为 ATN 合约地址，禁止对 ATN 地址发送转账交易。

StopTransferGurad.sol 代码如下：

```javascript
function onTokenTransfer(address _from, addres _to, uint _amount)
    public returns (bool) {
     if (!stopped &amp;&amp; isBlack[_from]) {
     return false;
     }
     return true;
    }
```

isBlack 存储所有黑客非法发行 ATN 的账户地址，支持动态更新。所有转账到这些的 ATN 也将无法转账。

stopped 该Guard的开关。

安全审计结果：

模拟冻结黑名单地址转账结果：

[https://kovan.etherscan.io/tx/0x68755305fee0d995f4ee79f6ab9d14e1aaf5d4b1c2d5838acbbaff464b6579d5](https://kovan.etherscan.io/tx/0x68755305fee0d995f4ee79f6ab9d14e1aaf5d4b1c2d5838acbbaff464b6579d5)

模拟向ATN合约转账结果：

[https://kovan.etherscan.io/tx/0x78738ab30a507ac209fb4aaf80be7e92c558bff8767887d3e1f4e0a445f16444](https://kovan.etherscan.io/tx/0x78738ab30a507ac209fb4aaf80be7e92c558bff8767887d3e1f4e0a445f16444)

模拟黑客攻击结果：

[https://kovan.etherscan.io/tx/0x7c72613fca4440b7775d08fde6beeba0e428a975cdf58a912ee76cb0e1ea87af](https://kovan.etherscan.io/tx/0x7c72613fca4440b7775d08fde6beeba0e428a975cdf58a912ee76cb0e1ea87af)

转账都失败，判定漏洞已修复。

最终，黑客向交易所进行充值，获得证据

[https://etherscan.io/tx/0x18bd80b810f6a6b6d397901d677657d39f8471069bcb7cfbf490c1946dfd617d](https://etherscan.io/tx/0x18bd80b810f6a6b6d397901d677657d39f8471069bcb7cfbf490c1946dfd617d)

Guard安全修复合约即刻部署，黑客相关地址予以禁止转账处理。

ATN将在交易所配合的情况下向黑客进行追踪，并保留向执法机构报案的权利。基金会[销毁](https://etherscan.io/tx/0xd8bfe8948259a0de2d28d14c6e45bda41ea09dc557ef38765964d6816c6bea8a "销毁") 1100w ATN，恢复 ATN 总量，并将在主链上线时对黑客地址内的资产予以剔除。

#### 总结

“合约无小事”

由于 ATN 合约设计增加多项功能及治理机制，增加了审计的难度和复杂度，在发布到链上之前进行的几次内部和外部审计均未发现该漏洞。

攻击发生后，ATN技术团队及时察觉极速反应并部署了ATN Token合约的防御措施并迅速修复了此未知漏洞；在实时监测到黑客将资金转入交易所地址基本可断定为黑客攻击（而非白帽行为）后，跟相关交易所协商追踪黑客信息并保留追责权利。

合约的安全审计，仅依靠开发者的经验和能力总有隐患，过去业内的几次合约漏洞事件也说明了这个问题。将来我们需要有更多的类似形式化验证的工具来帮助开发者发现潜在问题，从而编写更加健壮的合约。

#### 对其他以太坊Token合约的预警:

所有同时用到类似ERC223推荐实现的custom_fallback和ds-auth的合约，或者说内置有其他权限控制得合约，很可能也存在这个漏洞，需要检查确认。

ERC223的这个custom_fallback 的call处理，可以让public获取Token合约的this作为msg.sender调用其他方法(虽然参数限定，但是也可以通过编码的方式hack)，另外ds-auth默认是this可以获得授权，这边有一些争议，是否ds-auth默认授权范围太大。

> BUG记录于 https://paper.seebug.org
