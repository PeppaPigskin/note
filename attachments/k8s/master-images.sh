#!/bin/bash

# 定义master想要使用的所有docker镜像
images=(
    kube-apiserver:v1.17.3
    kube-proxy:v1.17.3
    kube-controller-manager:v1.17.3
    kube-scheduler:v1.17.3
    coredns:1.6.5
    etcd:3.4.3-0
    pause:3.1
)

# 遍历循环下载所需镜像
for imageName in ${images[@]} ; do
    docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName
    # 给每个镜像打个标签,认为它是从k8s.gcr.io下载的指定镜像,启动时就可以不用指定镜像仓库地址
    # docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName
done