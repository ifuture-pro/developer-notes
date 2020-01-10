Parity Wallet Multisig Hack
-------

## 第一次攻击
2017年7月19日，Parity multisig Contract 发生黑客事件。

攻击者从 Parity 多重签名合约中转走153,037 ETH
> 相关交易  
https://etherscan.io/tx/0x9dbf0326a03a2a3719c27be4fa69aacc9857fd231a8d9dcaede4bb083def75ec  
https://etherscan.io/tx/0xeef10fc5170f669b86c4cd0444882a96087221325f8bf2f55d6188633aa7be7c  
https://etherscan.io/tx/0x97f7662322d56e1c54bd1bab39bccf98bc736fcb9c7e61640e6ff1f633637d38  
https://etherscan.io/tx/0x0e0d16475d2ac6a4802437a35a21776e5c9b681a77fef1693b0badbb6afdb083

可以看到第一个交易从 [`initWallet`](https://github.com/paritytech/parity/blob/4d08e7b0aec46443bf26547b17d10cb302672835/js/src/contracts/snippets/enhanced-wallet.sol#L216) 开始，它可以更改合约的所有者。

```javascript
  // constructor - just pass on the owner array to the multiowned and
  // the limit to daylimit
  function initWallet(address[] _owners, uint _required, uint _daylimit) {
    initDaylimit(_daylimit);
    initMultiowned(_owners, _required);
  }
```

攻击者调用了合约的 `initWallet` 方法，为什么呢？主要是这个[`delegatecall`](https://solidity.readthedocs.io/en/v0.6.1/types.html#members-of-addresses)。  
合约使用 `delegatecall` 将所有不匹配的函数调用转发给库，这使得来自库的所有公共函数都可以被任何人调用，包括 `initWallet`

```javascript
function() payable {
    // just being sent some cash?
    if (msg.value > 0)
      Deposit(msg.sender, msg.value);
    else if (msg.data.length > 0)
      _walletLibrary.delegatecall(msg.data);
  }
```

### 解决方案
解决方案也非常简单，添加了一个修饰限制 `initWallet` 方法，确保它只能在构建过程中被调用一次。

```
modifier only_uninitialized { if (m_numOwners > 0) throw; _; }
```

## 第二次攻击
2017年11月7号，事隔4个月又一次攻击，估计损失可能超过500,000 ETH (1.5亿美元) ，其中包括来自 Web3基金会团队的300,000 ETH。

最新的攻击并不是针对单个的钱包合同，而是袭击了库合约，这将影响所有依赖于它的钱包合同。

11月7号一名 Github 用户 devops199 创建了一个[issues#6995](https://github.com/paritytech/parity-ethereum/issues/6995)ー“任何人都可以取消你的合同”。用户声称，他意外地杀死了合同。

这导致所有依赖于它的钱包合约，将所有调用指向了一个没有代码的合约地址（因为合约已经被 suicide），从而变得无法执行任何操作，因为它们的所有逻辑都依赖于库合约。 换句话说所有的钱包合同立即冻结。

## 最后

其实将逻辑抽象到一个库合约中的技术非常有用。有助于提高代码的可重用性，并降低气体部署成本。但是 bug 无处不在，学习历史，知道历史,是为了少踩坑。**前辈们的成功我们可能无法复制，但学习他们的失败可以帮助我们绕开那些坑**


-------------
相关报道

* https://blog.openzeppelin.com/on-the-parity-wallet-multisig-hack-405a8c12e8f7/
* https://blog.openzeppelin.com/parity-wallet-hack-reloaded/
* https://blog.springrole.com/parity-multi-sig-wallets-funds-frozen-explained-768ac072763c
