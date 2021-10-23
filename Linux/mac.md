## homebrew

替换brew.git
```
cd "$(brew --repo)”
git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git
```
替换homebrew-core.git:
```
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git
```

替换homebrew-bottles
```
echo $SHELL # 看输出结果是/bin/zsh还是/bin/bash

echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc

echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile
```

关闭brew每次执行命令时的自动更新
```
export HOMEBREW_NO_AUTO_UPDATE=true
```

```
brew search go
brew info go
brew install go@1.1
brew services start mariadb@10.1
```

[aliyun mirror](https://developer.aliyun.com/mirror/homebrew?spm=a2c6h.13651102.0.0.3e221b11s6RwUT)
