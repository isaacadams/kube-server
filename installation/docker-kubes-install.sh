#!/bin/bash

apt-get update && apt-get install -y gnupg2 apt-transport-https ca-certificates curl

source /etc/os-release
CODENAME=$(echo "$VERSION_CODENAME") #the codename or version: jessie, buster
CODENAME=$(cat /etc/os-release | grep -oP -m 1 '(?<=\()\w+')
DISTRO=$(echo "$ID") #the distribution: debian, unbuntu, fedora
ARCH=$(dpkg --print-architecture) #the architecture: amd64

# Get the Docker signing key for packages
curl -fsSL https://download.docker.com/linux/$DISTRO/gpg | apt-key add -

# Add the Docker official repos
echo "deb [arch=$ARCH] https://download.docker.com/linux/${DISTRO} ${CODENAME} stable" | \
   	tee /etc/apt/sources.list.d/docker.list

# Get the Kubes signing key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Add the official repos
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | \
      tee /etc/apt/sources.list.d/kubernetes.list

# Install Docker
# The aufs package, part of the recommended packages,
# won't install on Buster just yet,
# because of missing pre-compiled kernel modules.
# We can work around that issue by using --no-install-recommends
apt update
apt install -y --no-install-recommends \
   docker-ce docker-ce-cli containerd.io \
   kubelet kubeadm kubectl

apt-mark hold kubelet kubeadm kubectl docker-ce docker-ce-cli containerd.io