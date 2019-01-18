#!/bin/bash

# Ubuntu 18.04 LTS prep for Kubernetes on Azure
# run as root

# Workaround for local name resolution
if [ $# -ge 1 ]
    then
        sed -i '1i127.0.0.1 $1' /etc/hosts
fi

# Update system
apt-get update && apt-get upgrade -y

# Install and enable docker
apt-get install docker.io -y
systemctl enable docker

# Add the signing key and the repo
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add

# Will change to bionic once it exists
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

# Update the system again, just in case
apt-get update && apt-get upgrade -y

# Install kubeadm
apt install kubeadm -y

if [$# -eq 4]
    then
        kubeadm join $2 \
                --token $3 \
                --discovery-token-ca-cert-hash $4
fi

# for master
# kubeadm init --pod-network-cidr=10.244.0.0/16
# mkdir -p $HOME/.kube
# cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml


