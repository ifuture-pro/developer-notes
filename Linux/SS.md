# SS

## 服务器使用ss
```shell
# 安装SS
apt-get update
apt install shadowsocks-libev

# 安装 obfs plugin
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake
git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
make install

# 使Obfs-server能够监听端口443
setcap cap_net_bind_service+ep /usr/local/bin/obfs-server
```

编辑`/etc/shadowsocks-libev/config.json`
```json
{
  "server": "0.0.0.0",
  "server_port": 13003,
  "password": "mypassword",
  "timeout": 60,
  "method": "aes-256-gcm",
  "mode": "tcp_and_udp",
  "plugin": "obfs-server",
  "plugin_opts": "obfs=http;obfs-host=db5801e05e.microsoft.com",
  /* "plugin_opts": "obfs=tls;obfs-host=www.bing.com",
  "workers":8,
  "method":"chacha20-ietf-poly1305",
  "local_port":1080,
  "fast_open":true,
  "reuse_port":true */
}
```
防火墙与日志
```SHELL
iptables -I INPUT 1 -p tcp --dport 13003 -j ACCEPT

journalctl -u shadowsocks-libev-obfs.service -n 50
```

## 客户端使用clash
```yaml
#port: 7890
#socks-port: 7891
#listen: 192.168.1.25
mixed-port: 7890
socks-port: 7891
port: 7892
allow-lan: true
mode: Rule
log-level: info
external-controller: ':9090'
proxies:
    - { name: SG|SS, type: ss, server: ipaddress, port: 13003, cipher: aes-256-gcm, password: 'mypassword', plugin: obfs, plugin-opts: { mode: http, host: db5801e05e.microsoft.com }, udp: true }

```
