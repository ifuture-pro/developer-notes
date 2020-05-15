Openconnect
-----------------

## 安装 client

### Ubuntu
```bash
apt-get install openconnect vpnc network-manager-openconnect
```

### Mac
```bash
brew install openconnect

brew cask install openconnect-gui
```

### Mobile
ISO、Andorid : [Cisco AnyConnect](https://apps.apple.com/cn/app/cisco-anyconnect/id1135064690)

## Server
[ocservauto.sh](./ocservauto.sh)



```
You could use ' sudo ocpasswd -c /etc/ocserv/ocpasswd username ' to add users.
You could stop ocserv by ' /etc/init.d/ocserv stop '!
Boot from the start or not, use ' sudo insserv ocserv ' or ' sudo insserv -r ocserv '.
```

Tor（The Onion Router）
----------
洋葱路由
