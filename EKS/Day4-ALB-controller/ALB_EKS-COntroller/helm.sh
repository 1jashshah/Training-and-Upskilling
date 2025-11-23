#!/bin/bash

set -e

echo "Updating system..."
sudo apt-get update -y

echo "Installing required packages..."
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

echo "Creating keyrings directory..."
sudo mkdir -p /etc/apt/keyrings

echo "Downloading Helm GPG key..."
curl -fsSL https://baltocdn.com/helm/signing.asc | \
  sudo gpg --dearmor -o /etc/apt/keyrings/helm.gpg

echo "Adding Helm repo..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/helm.gpg] \
https://baltocdn.com/helm/stable/debian/ all main" | \
  sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

echo "Updating apt package index..."
sudo apt-get update -y

echo "Installing Helm..."
sudo apt-get install -y helm

echo "Helm installation completed successfully!"
helm version
