# 常用列表
## linux
* ls 显示文件年份
```shell
ls -l --time-style=full-iso
ls -l --time-style=long-iso
ls -l --time-style="+%Y-%m-%d %H:%I:%S"
ls -lc filename --列出文件的 ctime （最后权限时间）
ls -lu filename --列出文件的 atime（最后读取时间）
ls -l filename --列出文件的 mtime （修改文件内容）
```
