Solidity
-----------
[Solidity](https://solidity.readthedocs.io/) 是一门面向合约的、为实现智能合约而创建的高级编程语言，运作在以太坊虚拟机（EVM）上。

[官方文档](https://solidity.readthedocs.io/)
[中文文档](https://learnblockchain.cn/docs/solidity/)


## ABI
Application Binary Interface(ABI)

## Event/Log

```javascript

pragma solidity >=0.4.21 <0.7.0;
contract Demo {
  // 定义事件
  event Transfer(address indexed from, address indexed to, uint256 value);

  function bid() public payable {
    //触发事件
    emit Transfer(msg.sender, _to, _value);
  }
}
```

最多三个参数可以使用 `indexed` 属性
  * 这些参数会使用 `keccak-256` 哈希后得到值被作为 `topic` 保存在区块的 Event 里
  * API调用时可以使用这些 `indexed` 参数的特定值来进行过滤
```javascript
var event = demoContract.Transfer({from: ["xxxx","xxxx","xxxxx"]});
```

高效使用：
* 异步获取执行结果
* 和前端交互
* 存储合约数据，巧用日志去存储数据，可以大大减少交易费用
  > storage存储的大概价格为：每32字节需要消耗20000Gas，而日志存储价格大概为每字节8Gas


## 修饰符

**修饰函数**
* `pure` - 不允许修改和访问状态
* `view` - 不允许修改状态
* `payable` - 允许调用接收 以太币

**修饰函数和变量**

* `constant`

  函数：与`view`等价。  
  变量：不允许赋值（初始化除外），它不会占据 `storage slot`

* `external` - 可以从其他合约和交易中调用
* `public` - 可以在内部或通过消息调用。

  变量：会自动生成一个 `getter` 函数

* `internal` - 只能是内部访问
* `private` - 仅在当前定义它们的合约中使用，并且不能被派生合约使用

**修饰事件参数**

* `indexed` - 可作为索引
* `anonymous` - 事件签名的哈希值不会在 `topic` 中存储

**修饰器**
* `modifier` - [修饰器](https://solidity-cn.readthedocs.io/zh/develop/contracts.html#modifier)
