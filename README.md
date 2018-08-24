# Docker 搭建 PHP 开发环境

> 又多了一个...

## 核心组件

- [PHP](http://php.net)
- [Nginx](http://nginx.org)
- [MySQL](http://mysql.com)
- [PostgreSQL](https://www.postgresql.org)
- [Redis](https://redis.io)
- [MongoDB](https://www.mongodb.com)
- [Portainer](https://portainer.io)

## PHP 扩展

常用的已经包含 PHP 标准镜像内，下面是额外激活的：

- [OpCache](http://php.net/opcache)
- [xdebug](https://xdebug.org)
- [php_mysql](http://php.net/pdo_mysql)
- [phpredis](https://github.com/phpredis/phpredis)
- [sockets](http://php.net/sockets)

## 编译

不需要编译，但是 PHP 还是提供了 Dockerfile，如果你想自行编译 PHP，需要做一点小改动。
修改 docker-compose.yml，去掉 build 和 context 之前的注释（注意缩进），
然后把上面一行的 image 字段整行删掉或者随便填写一个新的名字以及 TAG。

比如：

```yaml
image: php:7-fpm-mine
build:
    context: ./php
```

然后运行下面的命令开始编译：

```bash
docker-compose build
```

或者使用 [Docker HUB](https://hub.docker.com) 提供的自动编译功能。

以下是简单的步骤：

1. fork 本库
2. DockerHUB 注册账号并创建一个自动编译仓库
3. 与你的 Github 仓库关联
4. 设定 Dockerfile 的相对路径，设定触发器
5. 修改 docker-compose.yml，image 的值改为你的镜像地址以及TAG

## 启动与停止：

```bash
# 启动
docker-compose up

# 后台运行
docker-compose up -d

# 停止并清理容器和网络
docker-compose down
```

## 其它常用命令

```bash
# 根据名称进入容器
docker exec -it (docker ps -aqf "name=docker-mysql") /bin/bash

# 清理所有的容器
docker rm $(docker ps -a -q)

# 清理所有的镜像
docker rmi $(docker images -a -q)

# 清理无用的网络
docker network prune
```

## 内核参数

如果你的宿主机是 Linux 系统，启动时可能会在 Redis 或者 MongoDB 的日志中看到类似的信息：

```log
WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.

WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.

WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
```

提供了一个简单的脚本 [hugepage-fix-arch.sh](https://github.com/verdana/docker-nmp/blob/master/hugepage-fix-arch.sh) 来修复 THP 的问题，不过永久禁用目前仅对 Arch 有效。

如果系统使用了 systemd 作为 init 系统，那么可以激活 [hugepage-fix.service](https://github.com/verdana/docker-nmp/blob/master/hugepage-fix.service)，在每次启动时自动修改相关的文件禁用 THP。

内核参数可以使用 docker run --sysctl 参数来修改，也可以写在 [docker compose](https://docs.docker.com/compose/compose-file/#sysctls) 的配置文件中，但支持的参数有限。

所以最好的方法是自行修改宿主机的内核参数让 Docker 自动继承，大部分发行版只要修改 /etc/sysctl.conf:

```conf
net.core.somaxconn = 512
vm.overcommit_memory = 1
```

某些发行版可能不太一样，像是 Arch Linux 需要在 /etc/sysctl.d/ 目录中建立一个文件，比如 99-sysctl.conf。

## MySQL

MySQL 镜像在 docker.cnf 中加入一个服务器参数 skip-name-resolve 禁用了 dns lookup，以提高服务器的响应速度。
但是这个参数启用以后 localhost 不再表示本机回环地址（不等于 127.0.0.1），所有系统权限表中的主机字段含有 localhost 的行都挂了，但并不影响使用，因为你还有一个默认的 root@% 用户。

启动日志中会出现一堆警告信息，如果看着很烦，可以使用 [mysql-fix.sh](https://github.com/verdana/docker-nmp/blob/master/mysql-fix.sh) 把所有的 localhost 全部替换成 127.0.0.1。

