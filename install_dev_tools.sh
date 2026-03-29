#!/bin/bash

set -e

echo "🔧 Starting development tools installation..."

# --- Update system ---
echo "📦 Updating package list..."
sudo apt update

# --- Install Docker ---
if ! command -v docker &> /dev/null
then
    echo "🐳 Installing Docker..."
    sudo apt install -y ca-certificates curl gnupg lsb-release

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
        sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) \
      signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo usermod -aG docker $USER
    echo "✅ Docker installed"
else
    echo "✅ Docker already installed"
fi

# --- Install Docker Compose (plugin check) ---
if ! docker compose version &> /dev/null
then
    echo "🐳 Installing Docker Compose plugin..."
    sudo apt install -y docker-compose-plugin
else
    echo "✅ Docker Compose already installed"
fi

# --- Install Python 3.9+ ---
if ! command -v python3 &> /dev/null
then
    echo "🐍 Installing Python..."
    sudo apt install -y python3 python3-pip
else
    PY_VERSION=$(python3 -c 'import sys; print(sys.version_info[:2])')
    echo "✅ Python already installed: $PY_VERSION"
fi

# --- Install pip (if missing) ---
if ! command -v pip3 &> /dev/null
then
    echo "📦 Installing pip..."
    sudo apt install -y python3-pip
else
    echo "✅ pip already installed"
fi

# --- Install Django ---
if ! pip3 show django &> /dev/null
then
    echo "🌐 Installing Django..."
    pip3 install --user django
    echo "✅ Django installed"
else
    echo "✅ Django already installed"
fi

echo "🎉 All tools are ready!"