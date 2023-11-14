# #!/bin/bash
# #
# # Setup the runner to have the Azure CLI, Rust, and Candle pre-installed
# set -e
# # Define a working directory
# WORK_DIR="/opt/actions-runner"

# # Update system packages
# apt-get update

# # Install necessary packages
# apt-get install -y build-essential pkg-config libssl-dev protobuf-compiler git curl


# # Install Rust using rustup
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# # Ensure the cargo/bin directory is in PATH
# source $HOME/.cargo/env

# # Clone the candle repository
# git clone https://github.com/huggingface/candle.git /opt/candle

# # Install Azure CLI without using sudo
# curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# # Create a folder for the actions runner and download the package
# mkdir -p $WORK_DIR
# cd $WORK_DIR
# curl -O -L https://github.com/actions/runner/releases/download/v2.310.2/actions-runner-linux-x64-2.310.2.tar.gz
# tar xzf ./actions-runner-linux-x64-2.310.2.tar.gz

# # Cleaning up unnecessary files to save space
# apt-get clean
# rm -rf /var/lib/apt/lists/*



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

# # install rust 
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# source $HOME/.cargo/env

# install candle 
git clone https://github.com/huggingface/candle.git /opt/candle

# # Create a GitHub runner Token
# TOKEN=$(curl -X POST \
#             -H "Authorization: token $GITHUB_PAT" \
#             -H "Accept: application/vnd.github.v3+json" \
#             https://api.github.com/repos/alfredodeza/azure-spot-runner/actions/runners/registration-token | grep token | cut -d '"' -f 4)


# # Configure the runner
# $WORK_DIR/config.sh --unattended --url https://github.com/alfredodeza/azure-spot-runner --token $TOKEN




# #!/bin/bash
# #
# # Setup the runner to have the Azure CLI pre-installed as well as the Actions
# # Runner

# # Define a working directory
# WORK_DIR="/opt/actions-runner"

# # Install Azure CLI, should not use sudo
# curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# # Create a folder
# mkdir -p $WORK_DIR && cd $WORK_DIR

# # Download the latest runner package
# curl -O -L https://github.com/actions/runner/releases/download/v2.310.2/actions-runner-linux-x64-2.310.2.tar.gz

# # Extract the installer
# tar xzf ./actions-runner-linux-x64-2.310.2.tar.gz




# # Install CUDA Toolkit and Drivers
# sudo apt-get update
# sudo apt-get install -y build-essential dkms
# sudo apt-get install -y linux-headers-$(uname -r)
# sudo apt-get install -y wget git

# # Install CUDA Toolkit for Ubuntu 20.04
# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
# sudo dpkg -i cuda-keyring_1.0-1_all.deb
# sudo apt-get update
# sudo apt-get -y install cuda-drivers

# # install Rust CLI 
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# source "$HOME/.cargo/env"

# # Clone candle-core 
# git clone https://github.com/huggingface/candle.git

# # Add Rust and CUDA to PATH for all sessions
# # echo 'export PATH=/usr/local/cuda/bin:$PATH' >> $HOME/.profile
# echo 'export PATH=$HOME/.cargo/bin:$PATH' >> $HOME/.profile
# source $HOME/.profile

# #!/bin/bash
# set -e

# # Updating system packages
# apt-get update

# # Installing necessary dependencies
# apt-get install -y build-essential pkg-config libssl-dev protobuf-compiler jq git-lfs

# # Setting up Git LFS
# git lfs install

# # Installing Rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# source "$HOME/.cargo/env"

# # Cloning the necessary repository
# git clone https://github.com/huggingface/candle.git
# cd candle

# # Building the project
# cargo build --example whisper --release || echo 'Cargo build failed.'


# # Define the binary directory based on the project directory
# BINARY_DIR="$PROJECT_DIR/target/release/examples"
# echo "Binary directory: $BINARY_DIR"

# Navigate to the binary directory
# git init
# git config --global user.email "scott.lai@duke.edu"
# git config --global user.name "scottLL"
# git remote add origin https://github.com/nogibjj/candle_scott_Azure_vm.git
# echo 'target/release/examples/whisper filter=lfs diff=lfs merge=lfs -text' > .gitattributes
# git lfs track "target/release/examples/whisper"
# git add whisper .gitattributes
# git commit -m 'Add whisper binary'
# git push -u origin main