# 🚀 Prometheus Installation on Ubuntu

Welcome! This guide will walk you through installing and running **Prometheus** on an **Ubuntu** system step-by-step.

---

## 🛠️ Requirements
- Ubuntu 20.04+ system
- Terminal access with `sudo` privileges

---

## ⚙️ Step-by-Step Setup

### 🔄 1. Update the System
Keep your system packages up to date:
```bash
sudo apt update && sudo apt upgrade -y
```

### 👤 2. Create Prometheus User
Create a dedicated system user for Prometheus:
```bash
sudo useradd --no-create-home --shell /bin/false prometheus
```

### 📥 3. Download Prometheus
Download the latest release from GitHub:
```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.51.2/prometheus-2.51.2.linux-amd64.tar.gz

tar xvf prometheus-2.51.2.linux-amd64.tar.gz
cd prometheus-2.51.2.linux-amd64
```

### 📂 4. Move Binaries
Move the main binaries to your system PATH:
```bash
sudo cp prometheus /usr/local/bin/
sudo cp promtool /usr/local/bin/
```

### 🗂️ 5. Setup Directories
Create required directories and copy configuration:
```bash
sudo mkdir -p /etc/prometheus
sudo mkdir -p /var/lib/prometheus
sudo cp -r consoles /etc/prometheus
sudo cp -r console_libraries /etc/prometheus
sudo cp prometheus.yml /etc/prometheus/
```

Set proper ownership:
```bash
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
```

### 🔧 6. Create Systemd Service
Create the systemd service file:
```bash
sudo tee /etc/systemd/system/prometheus.service<<EOF
```
Paste this configuration:
```ini
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
```

### 🟢 7. Start & Enable Prometheus
```bash
sudo systemctl daemon-reexec
sudo systemctl enable prometheus
sudo systemctl start prometheus
```

Check status:
```bash
sudo systemctl status prometheus
```

### 🌐 8. Verify Installation
Open your browser and navigate to:
```
http://localhost:9090
OR
http://your_public_ip:9090
```
You should see the **Prometheus Dashboard**.
![image](https://github.com/user-attachments/assets/d2f52e04-3ca2-45e9-8ed7-4f214b55a558)

---

## ✅ Next Steps
🔸 Install **Node Exporter** to monitor system metrics  
🔸 Integrate with **Grafana** for visual dashboards  
🔸 Define alerting rules in `prometheus.yml`

---

## 📁 Directory Structure
```
/etc/prometheus/
├── prometheus.yml
├── consoles/
└── console_libraries/
```
