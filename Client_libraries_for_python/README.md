# 📊 Prometheus Monitoring with Python Client Library

This project demonstrates how to use the [Prometheus Python client](https://github.com/prometheus/client_python) to expose and monitor custom metrics from a Python application. It serves as a beginner-friendly template for integrating Prometheus into Python-based systems.

---

## 🚀 Features

- 📈 Exposes custom application metrics using **Counters** and **Gauges**
- 🌐 Serves metrics via an HTTP endpoint (`/metrics`)
- ⚙️ Ready-to-use `prometheus.yml` configuration file
- 🧪 Includes a test script for demonstration
- 📦 Simple `requirements.txt` to set up dependencies

---

## 📂 Folder Contents

| File Name             | Description |
|----------------------|-------------|
| `Gauges_and_Counter.py` | Example of custom metrics using Prometheus client (counters & gauges) |
| `prom_test.py`        | Runs a local HTTP server exposing metrics to Prometheus |
| `prometheus.yml`      | Prometheus scrape configuration file |
| `requirements.txt`    | Python dependencies required for the project |

---

## ⚙️ Setup Instructions

```bash
# 1. Clone the repository
git clone https://github.com/M-Tayyab06/Prometheus.git
cd Prometheus/Client_libraries_for_python

# 2. Create a virtual environment
python3 -m venv venv
source venv/bin/activate

# 3. Install dependencies
pip install -r requirements.txt

# 4. Run the sample script
python prom_test.py
```

Visit [http://localhost:8000/metrics](http://localhost:8000/metrics) to see exposed metrics.
<img width="843" height="589" alt="image" src="https://github.com/user-attachments/assets/3e738884-f5c6-4ef4-bcd9-5ca6f5454e52" />

<img width="1364" height="327" alt="image" src="https://github.com/user-attachments/assets/862e97c9-34ae-4cdc-8a08-7c4708427f58" />


---

## 📡 Configuring Prometheus

To scrape metrics from your Python app, add this job to your `prometheus.yml`:

```yaml
scrape_configs:
  - job_name: 'python-app'
    static_configs:
      - targets: ['instance_ip:8000']
```

---

## 🌟 Why This Matters

Prometheus is a leading monitoring solution used in DevOps and Site Reliability Engineering (SRE). Integrating it into Python applications helps:

- Identify performance bottlenecks
- Visualize custom KPIs in Grafana
- Build reliable, production-ready microservices
- Enable proactive monitoring with alerting

---

## 🔗 Project Link

[👉 GitHub Repository](https://github.com/M-Tayyab06/Prometheus/tree/main/Client_libraries_for_python)

---
`#Prometheus` `#Python` `#Monitoring` `#Metrics` `#DevOps` `#OpenSource` `#Observability`
