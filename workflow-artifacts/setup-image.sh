#!/bin/bash
# Setup the runner to have the Azure CLI and other dependencies pre-installed

# Exit script on error
set -e

# Define a working directory
WORK_DIR="/opt/actions-runner"
RUNNER_VERSION="2.310.2"  # Update to the desired version

# Update and install system dependencies
apt-get update
apt-get install -y curl tar sudo git build-essential pkg-config libssl-dev apt-transport-https ca-certificates

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash
az --version || { echo "Azure CLI installation failed"; exit 1; }

# Install GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt update && apt install -y gh
gh --version || { echo "GitHub CLI installation failed"; exit 1; }

# Install Rust and Cargo (if needed for your setup)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
rustc --version || { echo "Rust installation failed"; exit 1; }

# Create a directory for the runner and navigate to it
mkdir -p "${WORK_DIR}" && cd "${WORK_DIR}"

# Download the specified version of the GitHub Actions runner
curl -o "actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" -L "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"

# Extract the installer
tar xzf "./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" || { echo "Extracting runner failed"; exit 1; }

# Clean up the tarball
rm -f "./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"

# Create a runner user and assign ownership of the directory
RUNNER_USER="runner"
useradd -m -s /bin/bash "${RUNNER_USER}"
echo "${RUNNER_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
chown -R "${RUNNER_USER}":"${RUNNER_USER}" "${WORK_DIR}"

# Set the correct permissions for the scripts
chmod +x "${WORK_DIR}"/bin/*.sh

# Clone the candle repository
git clone https://github.com/huggingface/candle.git "${WORK_DIR}/candle"
chown -R "${RUNNER_USER}":"${RUNNER_USER}" "${WORK_DIR}/candle"

echo "All necessary components have been installed and configured."

# Any additional packages that need to be installed can be added here

# Note: Configuration and service installation steps should be in the cloud-init.txt
# or executed when the VM is deployed.

# Note: You would typically add your runner configuration and service installation steps
# when you're about to deploy the VM, not when you're creating the base image.
# These steps should be executed after the VM starts, so they are not included here.













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
# # source "$HOME/.cargo/env"

# # Clone candle-core 
# git clone https://github.com/huggingface/candle.git

# # Add Rust and CUDA to PATH for all sessions
# # echo 'export PATH=/usr/local/cuda/bin:$PATH' >> $HOME/.profile
# echo 'export PATH=$HOME/.cargo/bin:$PATH' >> $HOME/.profile
# source $HOME/.profile


# cd candle
