# 📊 Node Exporter Installation on Ubuntu

This guide walks you through setting up **Node Exporter** on Ubuntu, which allows Prometheus to collect hardware and OS-level metrics from your machine.

---

## 🛠️ Requirements
- Ubuntu 20.04+ system
- Prometheus already installed and running
- Terminal access with `sudo` privileges

---

## ⚙️ Step-by-Step Setup

### 🔄 1. Update the System
```bash
sudo apt update && sudo apt upgrade -y
```

### 📥 2. Download Node Exporter
Go to [Node Exporter Releases](https://github.com/prometheus/node_exporter/releases) and download the latest version:
```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz

tar xvf node_exporter-1.8.1.linux-amd64.tar.gz
cd node_exporter-1.8.1.linux-amd64
```

### 🚚 3. Move Binary & Create User
```bash
sudo cp node_exporter /usr/local/bin/
sudo useradd -rs /bin/false node_exporter
```

### 🔧 4. Create Systemd Service
Create a systemd service to run Node Exporter as a background process:
```bash
sudo nano /etc/systemd/system/node_exporter.service
```
Paste this configuration:
```ini
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
```

### ▶️ 5. Start & Enable the Service
```bash
sudo systemctl daemon-reexec
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
```

Check status:
```bash
sudo systemctl status node_exporter
```

### 🌐 6. Verify It's Running
Visit the metrics endpoint in your browser or curl:
```
http://localhost:9100/metrics
```
![image](https://github.com/user-attachments/assets/60257ca6-644a-4238-8eaa-9320c3277197)

---

## 🔗 7. Add Node Exporter to Prometheus
Edit your Prometheus config file:
```yaml
# /etc/prometheus/prometheus.yml
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
```

Then reload Prometheus:
```bash
sudo systemctl restart prometheus
```
![image](https://github.com/user-attachments/assets/0efff06a-5471-45ac-b854-82840e7a6b7a)
