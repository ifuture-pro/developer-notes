Java 字节码 Bytecode
----------

从写 Java 文件到通过编译器编译成 class 文件（也就是字节码文件），再到虚拟机执行 class 文件。不论该字节码文件来自何方，由哪种编译器编译，甚至是手写字节码文件，只要符合java虚拟机的规范，那么 jvm 就能够执行该字节码文件。

## 简述
Demo.java
```java
package pro.ifuture.myday.utils;

public class Demo {
	private String text = "hello world";

	public static void main(String[] args) {
		System.out.print("hello world");
	}
}
```

执行 `javac Demo.java` 得到 `Demo.class`

```
CAFEBABE 00000037 00210A00 07001208
00130900 06001409 00150016 0A001700
18070019 07001A01 00047465 78740100
124C6A61 76612F6C 616E672F 53747269
6E673B01 00063C69 6E69743E 01000328
29560100 04436F64 6501000F 4C696E65
4E756D62 65725461 626C6501 00046D61
696E0100 16285B4C 6A617661 2F6C616E
672F5374 72696E67 3B295601 000A536F
75726365 46696C65 01000944 656D6F2E
6A617661 0C000A00 0B01000B 68656C6C
6F20776F 726C640C 00080009 07001B0C
001C001D 07001E0C 001F0020 01001C70
726F2F69 66757475 72652F6D 79646179
2F757469 6C732F44 656D6F01 00106A61
76612F6C 616E672F 4F626A65 63740100
106A6176 612F6C61 6E672F53 79737465
6D010003 6F757401 00154C6A 6176612F
696F2F50 72696E74 53747265 616D3B01
00136A61 76612F69 6F2F5072 696E7453
74726561 6D010005 7072696E 74010015
284C6A61 76612F6C 616E672F 53747269
6E673B29 56002100 06000700 00000100
02000800 09000000 02000100 0A000B00
01000C00 00002700 02000100 00000B2A
B700012A 1202B500 03B10000 0001000D
0000000A 00020000 00070004 00080009
000E000F 0001000C 00000025 00020001
00000009 B2000412 02B60005 B1000000
01000D00 00000A00 02000000 0B000800
0C000100 10000000 020011
```

一个16进制的代码文件，其实很多需要编译的编程语言的虚拟机都是这样的，编译器先将源文件编译成16进制的文件，有着自己的字节码解析规则，比如区块链以太坊的EVM，非常类似。

java字节码解读表

|占位| 名称 | 解释|
|----|----|----|
|4个字节| Magic Number  | 魔数|
|2+2个字节| Version| 次主版本号|
|2+n个字节| Constant Pool | 常量池|
|2个字节| Access Flags | 访问标志|
|2个字节| This Class Name| |
|2个字节| Super Class Name| |
|2+n个字节| Interfaces| |
|2+n个字节| Fields| |
|2+n个字节| Methods| |
|2+n个字节| Attributes| |

## JavaAgent
在JDK1.5后开始出现了 javaagent 它提供了操作运行时字节码的机制，包：`java.lang.instrument`。可以把它理解为虚拟机级别的AOP

**部署**  
`-javaagent:/path/myAgent.jar`

**代码**  
```java
import java.lang.instrument.Instrumentation;

public class Agent {
    // main 方法前执行
    public static void premain(String args, Instrumentation inst) {
        try {
            //KeyTransformer implements java.lang.instrument.ClassFileTransformer
            inst.addTransformer(new KeyTransformer());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    // main 方法后执行
    public static void agentmain(String agentArgs, Instrumentation inst){

    }
}
```
**打包**
META-INF/MANIFEST.MF
```
Manifest-Version: 1.0
Implementation-Title: myAgent
Premain-Class: pro.ifuture.agent.Agent
Implementation-Version: 1.0-SNAPSHOT
Built-By: ifuture
```
使用maven时  
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-assembly-plugin</artifactId>
    <version>3.0.0</version>
    <configuration>
        <archive>
            <manifest>
                <addClasspath>false</addClasspath>
            </manifest>
            <manifestEntries>
                <Premain-Class>pro.ifuture.agent.Agent</Premain-Class>
                <Main-Class>pro.ifuture.agent.Usage</Main-Class>
                <Can-Redefine-Classes>true</Can-Redefine-Classes>
            </manifestEntries>
        </archive>
        <descriptorRefs>
            <descriptorRef>jar-with-dependencies</descriptorRef>
        </descriptorRefs>
    </configuration>
    <executions>
        <execution>
            <id>make-assembly</id>
            <phase>package</phase>
            <goals>
                <goal>single</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

## 应用
* [asm](https://asm.ow2.io/) ASM库可以用来生成、转换和分析编译后的java类
* [Arthas](https://github.com/alibaba/arthas) Alibaba Java诊断利器Arthas
* [MyPerf4J](https://github.com/LinShunKang/MyPerf4J) 性能分析
* [Bistoury](https://github.com/qunarcorp/bistoury) 去哪儿网的java应用生产问题诊断工具
* idea debug -javaagent:/Users/xxx/Library/Caches/IntelliJIdea2019.3/captureAgent/debugger-agent.jar
* [Idea破解](https://zhile.io/2018/08/17/jetbrains-license-server-crack.html)
