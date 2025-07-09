#!/bin/bash

# --------------------------------------------
# Node Exporter Installation & Service Setup
# --------------------------------------------
# This script installs Prometheus Node Exporter and sets it up as a systemd service
# --------------------------------------------

# Set the version of Node Exporter
VERSION="1.8.1"

# Colors for output
GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

# Print step title
function print_step() {
    echo -e "\n${GREEN}==> $1${NC}"
}

# Download node_exporter
print_step "Downloading Node Exporter v$VERSION..."
curl -LO https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz

# Extract the archive
print_step "Extracting Node Exporter archive..."
tar xvf node_exporter-$VERSION.linux-amd64.tar.gz

# Move binary to /usr/local/bin
print_step "Moving binary to /usr/local/bin..."
sudo mv node_exporter-$VERSION.linux-amd64/node_exporter /usr/local/bin/

# Create a system user for node_exporter
print_step "Creating node_exporter user..."
sudo useradd -rs /bin/false node_exporter

# Create systemd service file
print_step "Creating systemd service file..."
cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service > /dev/null
[Unit]
Description=Prometheus Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start the service
print_step "Enabling and starting node_exporter service..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# Check the service status
print_step "Node Exporter Service Status:"
sudo systemctl status node_exporter --no-pager

print_step "Installation Complete. Access metrics at http://localhost:9100/metrics  OR  http://ip_address:9100/metrics"
