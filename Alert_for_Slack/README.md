# 🚨 Prometheus Alerting to Slack

This guide shows how to configure Prometheus and Alertmanager to send alerts to **Slack**.

---

## 📋 Prerequisites

* A running **Prometheus** instance
* **Alertmanager** installed and configured
* A **Slack Workspace** with permission to add apps
* A **Slack Webhook URL**

---

## 🔧 Step 1: Create a Slack Incoming Webhook

1. Go to [Slack API: Your Apps](https://api.slack.com/apps)
2. Click **Create New App > From scratch**
3. Enter app name and select your workspace
4. Under **Features**, click **Incoming Webhooks** and enable it
5. Click **Add New Webhook to Workspace**
6. Choose the target channel and click **Allow**
7. Copy the **Webhook URL** (you'll need this later)

---

## 🛠 Step 2: Configure Alertmanager for Slack

Edit your `alertmanager.yml`:

```yaml
global:
  resolve_timeout: 5m

route:
  receiver: 'slack_notifications'

receivers:
  - name: 'slack_notifications'
    slack_configs:
      - api_url: 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX'
        channel: '#alerts'
        text: "{{ .CommonAnnotations.summary }}\n\nDetails:\n{{ range .Alerts }}• {{ .Annotations.description }}\n{{ end }}"
```

🔁 Replace the `api_url` with your actual Slack Webhook URL.

---

## 🔄 Step 3: Reload Alertmanager

```bash
# If running as a service:
sudo systemctl restart alertmanager

# Or reload configuration without restart:
curl -X POST http://your_ip:9093/-/reload
```

---

## 📣 Step 4: Create a Sample Alert Rule

In your Prometheus alert rules file:

```yaml
groups:
  - name: ExampleAlerts
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Instance is down"
          description: "The instance {{ $labels.instance }} is down."
```

Reload Prometheus to apply the rule.

---

## ✅ Result in Slack

Your Slack channel will show a message like:

```
Instance is down

Details:
• The instance instance_ip:9100 is down.
```

---

## 🧪 Testing

Validate your configuration with:

```bash
amtool check-config /etc/alertmanager/alertmanager.yml
```

---

## 📌 Notes

* Slack alerts are customizable using Go templating
* Alerts can be routed based on severity or job type using advanced routing tree

---

## 📚 Resources

* [Prometheus Alerting Docs](https://prometheus.io/docs/alerting/latest/overview/)
* [Alertmanager Configuration](https://prometheus.io/docs/alerting/latest/configuration/)
* [Slack API Docs](https://api.slack.com/messaging/webhooks)
