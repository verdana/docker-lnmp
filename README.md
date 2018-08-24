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

- [OpCache](http://php.net/opcache)
- [xdebug](https://xdebug.org)
- [php_mysql](http://php.net/pdo_mysql)
- [phpredis](https://github.com/phpredis/phpredis)
- [sockets](http://php.net/sockets)

## 编译

不需要编译，但是 PHP 还是提供了 Dockerfile，如果你想自行编译 PHP，可以运行：

```bash
# docker-compose build
```


## 常用命令

```bash
# 清理所有的容器
docker rm $(docker ps -a -q)

# 清理所有的镜像
docker rmi $(docker images -a -q)

# 清理无有的网络
docker network prune
```

