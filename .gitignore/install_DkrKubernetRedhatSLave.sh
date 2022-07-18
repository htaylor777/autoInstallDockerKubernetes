#!/bin/bash
# This is an automation script to install Docker and Kubernetes
# 
#  Copyright Hilery Taylor 2022
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

clear
echo "============================================="
echo "REDHAT SLAVE AUTO-INSTALL DOCKER - KUBERNETES"
echo "============================================="

echo "...UPDAING APPS:"
sudo yum update

echo "...TURNING OFF SWAP--MASKING OUT SWAP in /etc/fstab:"
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "...ATTEMPTING TO INSTALL DOCKER:"
#install docker:
 sudo yum install docker.io -y

echo "...ATTEMPING TO INSTALL NET-TOOLS:"
 sudo yum install net-tools -y

echo "...ALLOWING FIREWALL PORT 6443:"
#open port 6443:
 sudo ufw allow 6443

echo "...INSTALLING CURL"
#install curl:
 sudo yum install -y apt-transport-https ca-certificates curl

echo "...ATTEMPTING TO INSTALL KUBERNETES GPG KEY:"
#install kubernetes gpg key:
 sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
 echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "...YUM UPDATE:"
#update refresh:
 sudo yum update
clear
echo "...ATTEMPTING TO INSTALL KUBERNETES:"
#install kubernetes (agent, admin and controller):
 sudo yum install -y kubelet kubeadm kubectl

echo "...INITIATING KUBERNTES ADM FOR MASTER:"
#initiate kubernetes administrator for master:
my_ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
echo "...EXECUTING:"
echo "sudo kubeadm init --apiserver-advertise-address=$my_ip --pod-network-cidr=192.168.0.0/16"
 sudo kubeadm init --apiserver-advertise-address=$my_ip --pod-network-cidr=192.168.0.0/16
 mkdir -p $HOME/.kube
 sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
 sudo chown $(id -u):$(id -g) $HOME/.kube/config
 sudo kubectl cluster-info
 sudo kubectl get nodes

 echo "kubernetes master setup completed!"
 echo "Does everything look okay? [y] or [n]"
 read ans

 if [ "$ans" == "y" ]; then
         echo "great job!"
 else
         echo "check errors and initiate [ sudo kubeadm reset ]"
         echo "or,[ sudo yum remove kubelet kubeadm kubectl ]"
         echo "then try to reinstall,[ sudo yum install -y kubelet kubeadm kubectl ]"
         fi

echo "GO TO URL TO COMPLETE THE INSTALL:Instructions to install CNI PLUGIN: https://projectcalico.docs.tigera.io/getting-started/kubernetes/hardway/install-cni-plugin"

