# Node Exporter Systemd Service Setup

This repository provides a complete guide and script to install and run Prometheus **Node Exporter** as a **systemd service** on **Ubuntu** (native or WSL with `systemd` support).

---

## 📦 Features

* Auto-download and install Node Exporter
* Create a dedicated user
* Configure and enable systemd service
* Persistent monitoring on reboots

---

## 📁 Files Included

| File                                       | Description                                       |
| ------------------------------------------ | ------------------------------------------------- |
| `node_exporter_service_setup.sh`           | Bash script to install Node Exporter as a service |
| `node_exporter.service` *(auto-generated)* | systemd unit file used by the script              |

---

## 🚀 How to Use

1. **Clone this repository:**

```bash
git clone https://github.com/your-username/node-exporter-service.git
cd node-exporter-service
```

2. **Make the script executable:**

```bash
chmod +x node_exporter_service_setup.sh
```

3. **Run the script:**

```bash
./node_exporter_service_setup.sh
```

4. **Check Node Exporter status:**

```bash
systemctl status node_exporter
```

---

## 🌐 Access Metrics

After successful setup, you can view metrics at:

```
http://localhost:9100/metrics
```

---

## ⚠️ WSL Notes

If you're using WSL2:

* Ensure `systemd` is enabled in your WSL distro (e.g., via [`genie`](https://github.com/arkane-systems/genie))
* Alternatively, run node\_exporter manually with:

```bash
/usr/local/bin/node_exporter
```
