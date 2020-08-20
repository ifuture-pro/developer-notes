# APP Signing

## Android
Android 应用签名是应用打包过程的重要步骤之一，Google 要求所有的应用必须被签名才可以安装到 Android 操作系统中。Android 的签名机制也为开发者识别和更新自己应用提供了方便。

* [Android](https://developer.android.com/studio/publish/app-signing)
* [Google pepk.jar](https://www.gstatic.com/play-apps-publisher-rapid/signing-tool/prod/pepk.jar)
* [Google pepk-src.jar](https://www.gstatic.com/play-apps-publisher-rapid/signing-tool/prod/pepk-src.jar)
* [pepk-src](https://github.com/yongjhih/pepk)

### KeyStore
数字证书，是一个存储了证书的文件。文件包含证书的私钥，公钥和对应的数字证书的信息。

* keytool

jdk 工具包，在 JAVA_HOME  下查找

```shell
# 生成 keystore
# validity 有效天数
keytool -genkey -alias ifuture -keyalg RSA -validity 365 -keystore ifuture.keystore

# 查看
keytool -list -v -keystore ifuture.keystore
```

* Android Studio

Build -> Generate signed Bundle/APK

一般使用 `keytool` 生成的密码库类型是 `PKCS12` ,Android Studio 生成的是 `JKS`

互相转换
```shell
# PKCS12 -> JKS
keytool -importkeystore -srckeystore ifuture.keystore -srcstoretype PKCS12 -deststoretype JKS -destkeystore ifuture.jks
# JKS -> PKCS12
keytool -importkeystore -srckeystore ifuture.jks -srcstoretype JKS -deststoretype PKCS12 -destkeystore ifuture.keystore
```

导入导出cert
```shell
keytool -export -alias cert0001 -keystore trust.jks -storepass 123456 -file cert0001.cer
keytool -import -v -alias cert001 -file cert001.cer -keystore trust.jks -storepass 123456 -noprompt

```

### 签名

* Android Studio

Build -> Generate signed Bundle/APK

* apksigner

Android SDK 工具包,在 Android 安装目录下查找
```
/Users/zzz/Library/Android/sdk/build-tools/29.0.3/apksigner
C:\\用户\zzz\AppData\Local\Android\Sdk\build-tools\29.0.3\apksigner.bat
```

```shell
# APK签名
apksigner sign --ks ifuture.jks --ks-key-alias ifuture --out app_sign.apk app-debug-unsign.apk
# 验证签名
apksigner verify -v C:\Users\fanqi\app_sign.apk
Verifies
Verified using v1 scheme (JAR signing): true
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): false
Number of signers: 1
# 代表使用了 v2 进行的签名
```

### 签名机制
* V1 JAR signing
> 第一代是基于 JAR 文件签名，它主要的缺陷是只保护了一部分文件，而不是对整个 APK 文件做保护。这是因为所有文件都不可能包含了自身的签名，因为它不可能为自己签名后再把签名信息保存到自己内部，这是一个鸡生蛋蛋生鸡的问题，因为这个问题的存在，第一代签名机制会忽略所有以 .SF/.DSA/.RSA 的文件以及 META-INFO 目录下的所有文件。 所以攻击者就可以解压缩后在 APK/META-INF 目录新增一个含有恶意代码的文件，然后再压缩成 APK，同样是可以覆盖安装正版应用的，这样一来好好的应用就会被杀毒软件标记为恶意软件，从而达到攻击应用的目的。 除了容易被攻击外，应用安装起来也比较慢，因为安装器在校验时需要解压计算所有文件的数字摘要，确认没有被恶意修改。

* V2
> Android 7.0 引入了第二代签名，避免了第一代签名模式的问题，主要改进在于它在验证过程中，将整个 APK 文件当作一个整体，只校验 APK 文件的签名就可以了，从而一方面更严苛的避免了 APK 被篡改，另外一方面也不用加压缩后对所有文件进行校验，从而极大提升了安装速度。第二代签名向后兼容，使用新签名的 APK 可以安装到 <7.0 的系统上，但要求 APK 同时也进行 v1 的签名。 具体来说，第二代签名将整个 APK 文件进行签名，并将签名信息保存在了 APK 文件的的尾部 Central Directory 的前边。它可以对第一三四，以及第二块除了签名部分的其他区域提供一致性保护。  
在计算签名的时候，会将这些部分的数据切割成 1MB 大小的 CHUNK，分别计算签名，然后汇总后再计算一个总签名，这么做的主要目的是为了并行计算，加快速度。  
为了避免攻击者在 7.0 以上系统中绕过 v2 签名机制（比如删除 APK Signing Block？），v2 签名要求如果 APK 同时提供了 V1 签名的话，需要在 META-INF/*.SF 文件中增加一行 X-Android-APK-Signed 属性，这样一来，支持 V2 签名的系统在回滚到 V1 签名的时候就会校验是否存在这个属性，如果存在，就会拒绝安装 APK，这一切都是建立在 *.SF 文件被 V1 签名保护的基础之上。

* V3
> Android 9.0 引入了第三代签名机制，主要增加一个功能叫 APK key rotation. 意思是允许开发者在更新 APK 的时候更换签名。签名的主要机制跟 V2 其实是一样的，只是重新设计了 APK Signing Block 的存储结构，以支持更换签名。这里就不再细说，可以参考官方的 文档 下图是安装一个 APK 时，系统对三代签名校验的流程示意。
