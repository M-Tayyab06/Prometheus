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

## 🧩 Configuration Details

### ✅ Global Section

```yaml
global:
  resolve_timeout: 1m
```

- Waits 1 minute before resolving an alert.

---

### 🔁 Route

```yaml
route:
  group_by: ['alertname']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 1h
  receiver: 'email_notification'
```

- Groups alerts by name
- Sends grouped alerts after 30s
- Repeats alert every 1h if still firing

---

### 📬 Email Receiver

```yaml
receivers:
  - name: 'email_notification'
    email_configs:
    - to: 'your_target_email@gmail.com'
      from: 'test@gmail.com'
      smarthost: 'smtp.gmail.com:587'
      auth_username: 'test@gmail.com'
      auth_identity: 'test@gmail.com'
      auth_password: 'your_app_password'
      send_resolved: true
```

- Use Gmail's **App Passwords** – generate from: [https://myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)
- App Password is 16-character secure login for Gmail apps

---

### 🔕 Inhibit Rules

```yaml
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']
```

- Prevents sending **warning-level alerts** if a **critical** one exists for the same instance

---

## ✅ Validating Config

Use Alertmanager CLI:

```bash
./amtool check-config configs/alertmanager.yml
```

---

## 🚀 Running Alertmanager

```bash
./alertmanager --config.file=configs/alertmanager.yml
```

---

## 📸 Optional Screenshots

Add screenshots of:
<img width="1365" height="443" alt="image" src="https://github.com/user-attachments/assets/43b2182e-b0e3-44ac-8966-97bbcc1ef58e" />
- Prometheus Showing Alert for the Firing alert
<img width="981" height="457" alt="image" src="https://github.com/user-attachments/assets/2feae9eb-b557-4797-9090-270a4140f66f" />
- Alertmanager UI showing active alerts
<img width="881" height="76" alt="image" src="https://github.com/user-attachments/assets/b3827fcd-0ee0-4c9b-b408-fb51a44eb601" />
<img width="551" height="489" alt="image" src="https://github.com/user-attachments/assets/61fd1236-1b90-4987-ab3b-8448d9088c2e" />
- Email received in your inbox

---

## 🧠 Best Practices

- Keep your App Password secret (never commit it!)
- Use `.env` or secret manager in production
- Test email with different severity levels

---
## 📬 Contact

**Muhammad Tayyab Shafique**  
DevOps Engineer  
📧 tayyab.shafique06@gmail.com  
📍 Lahore, Pakistan

---
