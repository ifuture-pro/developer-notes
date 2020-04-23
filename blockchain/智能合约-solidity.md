Solidity
-----------
[Solidity](https://solidity.readthedocs.io/) 是一门面向合约的、为实现智能合约而创建的高级编程语言，运作在以太坊虚拟机（EVM）上。

[官方文档](https://solidity.readthedocs.io/)  
[非官方中文文档](https://learnblockchain.cn/docs/solidity/)  
[Openzeppelin合约类库](https://github.com/OpenZeppelin/openzeppelin-contracts)  

> 以太坊虚拟机（EVM）是一个 “The World Machine” 所以请原谅它简陋的语法特性、令人抓狂的debug体验、近乎贫瘠的类库支持、动不动就需要插入汇编语句来解决一下问题。Solidity 语言在这种环境下必须严格遵循的设计原则以及权衡后必须付出的代价。

## ABI
Application Binary Interface(ABI)

## 存储
**栈** 用于存储字节码指令的操作数。在Solidity中，局部变量若是整型、定长字节数组等类型，就会随着指令的运行入栈、出栈。对于这类变量，无法强行改变它们的存储方式，如果在它们之前放置memory修饰符，编译会报错。  
**内存** 类似java中的堆，它用于储存"对象"。在Solidity编程中，如果一个局部变量属于变长字节数组、字符串、结构体等类型，其通常会被memory修饰符修饰，以表明存储在内存中。  
**状态存储** 用于存储合约的状态字段。从实现而言，不同的链可能采用不同实现，比较经典的是以太坊所采用的MPT树。由于MPT树性能、扩展性等问题，FISCO BCOS放弃了这一结构，而采用了分布式存储，通过rocksdb或mysql来存储状态数据，使存储的性能、可扩展性得到提高。
```javascript
contract Demo{
    //状态存储
    uint private _state;

    function set(uint state) public {
        //栈存储
        uint i = 0;
        //内存存储
        string memory str = "aaa";
    }
}
```

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
* 异步获取执行结果，并可提供过滤器，支持参数的检索和过滤。
* 提供一种回调机制，在事件执行成功后，由节点向注册监听的SDK发送回调通知，触发回调函数被执行。Oracle 的原理
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

* `external` - 可以从其他合约和交易中调用，不可内部调用，在接收大量数据时更为高效。

  当函数的某个参数非常大时，如果显式地将函数标记为external，可以强制将函数存储的位置设置为 `calldata`，这会节约函数执行时所需存储或计算资源。

* `public` - 可以在内部或通过消息调用。没指定默认为 public

  变量：会自动生成一个 `getter` 函数

* `internal` - 只能是内部访问

  变量：状态变量的修饰符默认是`internal`

* `private` - 仅在当前定义它们的合约中使用，并且不能被派生合约使用

**修饰事件参数**

* `indexed` - 可作为索引
* `anonymous` - 事件签名的哈希值不会在 `topic` 中存储

**修饰器**
* `modifier` - [修饰器](https://solidity-cn.readthedocs.io/zh/develop/contracts.html#modifier)

  有点面向切面编程的感觉。
```javascript
event LogStartMethod();
event LogEndMethod();
modifier logMethod {
    emit LogStartMethod();
    _;//表示所修饰函数中的代码,也就是在函数的最前与最后插入代码
    emit LogEndMethod();
}
function doing(address _owner) public logMethod {
    // something...
}
```

## 抽象类与接口
[docs](https://solidity-cn.readthedocs.io/zh/develop/contracts.html#index-17) 与其他语言类似。但需要注意合适地使用接口或抽象合约有助于增强合约设计的可扩展性。但是，由于区块链EVM上计算和存储资源的限制，切忌过度设计，这也是从高级语言技术栈转到Solidity开发的老司机常常会陷入的天坑。


## 常见问题
* 一个合约中，入参、返回值、内部变量不能超过了16个
```javascript
Compiler error: Stack too deep, try removing local variables.
```
EVM所设计用于最大的栈深度为16。所有的计算都在一个栈内执行，对栈的访问只限于其顶端，限制方式为：允许拷贝最顶端16个元素中的一个到栈顶，或者将栈顶元素和下面16个元素中的一个交换。所有其他操作都只能取最顶的几个元素，运算后，把结果压入栈顶。当然可以把栈上的元素放到存储或内存中。但无法只访问栈上指定深度的那个元素，除非先从栈顶移除其他元素。

  **建议** 使用结构体或数组来封装入参或返回值，达到减少栈顶元素使用的目的，从而避免此错误。对于智能合约也应该[避免过多的设计](./智能合约-设计模式.md)。需要分布式协作的重要数据才上链，非必需数据不上链；链上验证，链下授权。
