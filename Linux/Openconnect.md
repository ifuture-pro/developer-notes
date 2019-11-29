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

## Server
[ocservauto.sh](./ocservauto.sh)



```
You could use ' sudo ocpasswd -c /etc/ocserv/ocpasswd username ' to add users.
You could stop ocserv by ' /etc/init.d/ocserv stop '!
Boot from the start or not, use ' sudo insserv ocserv ' or ' sudo insserv -r ocserv '.
```
