#!/bin/bash
#
# Setup the runner to have the Azure CLI pre-installed as well as the Actions
# Runner

# Define a working directory
WORK_DIR="/opt/actions-runner"

# Install Azure CLI, should not use sudo
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Create a folder
mkdir -p $WORK_DIR && cd $WORK_DIR

# Download the latest runner package
curl -O -L https://github.com/actions/runner/releases/download/v2.310.2/actions-runner-linux-x64-2.310.2.tar.gz

# Extract the installer
tar xzf $WORK_DIR/actions-runner-linux-x64-2.310.2.tar.gz


# Install CUDA Toolkit and Drivers
sudo apt-get update
sudo apt-get install -y build-essential dkms
sudo apt-get install -y linux-headers-$(uname -r)
sudo apt-get install -y wget git
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget http://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda-repo-ubuntu2004-11-2-local_11.2.2-460.32.03-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-2-local_11.2.2-460.32.03-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-2-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda


# install Rust CLI 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

export PATH=/usr/local/cuda-11.8/bin:$PATH
export PATH=/home/ubuntu/.cargo/bin:$PATH

# get candle-core 
cargo new myapp
cd myapp
git clone https://github.com/huggingface/candle.git
