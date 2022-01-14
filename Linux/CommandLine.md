# 命令行

## Windows

* 程序后台运行
更好的方式[WinHidden](../Python/WinHidden.md)
```SHELL
@echo off
if "%1" == "h" goto begin
start mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit
:begin
##前四行是隐藏cmd窗口必不可少代码##

##下一句引号中内容
echo "Hello Wrold"

##下一句 cd 后面跟exe程序的绝对路径
cd D:\常用软件\6b\

##下一句 start /b 后跟exe程序 【全名】
start /b epoch.exe
```
