# 📡 Prometheus Email Alerts with Alertmanager

This repository shows how to configure Prometheus Alertmanager to send **email alerts** via **Gmail SMTP**.

---

## 📂 Folder Structure

```
This setting is for MAC or windows 
configs/
└── alertmanager.yml    # Main configuration for Alertmanager
But if you are using Ubuntu or Linux and you have setted things up just like they are told in this github repository then
/var/lib/alertmanager/alertmanager.yml
this would be the path
```
---

## 🔧 Prerequisites

- Prometheus installed and running
- Alertmanager installed and linked to Prometheus
- Gmail account with [App Password](https://support.google.com/accounts/answer/185833)

---

## 📤 How Email Alerts Work

1. Prometheus detects an alert (via defined rules).
2. Sends it to Alertmanager.
3. Alertmanager groups the alert and notifies you via email (as per `alertmanager.yml`).

---
