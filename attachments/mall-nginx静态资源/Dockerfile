# 从官方镜像拉取一个
FROM nginx
MAINTAINER pigkin
# 将自己的需要放入的文件爱添加到内部
ADD html.tar.gz /usr/share/nginx/html
ADD conf.tar.gz /etc/nginx
# 暴露80端口
EXPOSE 80
ENTRYPOINT nginx -g "daemon off;"