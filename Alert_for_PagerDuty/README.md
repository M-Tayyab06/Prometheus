# 🚨 Prometheus Alerting to PagerDuty

This guide explains how to set up **Prometheus and Alertmanager** to send alerts to **PagerDuty**.

---

## 📋 Prerequisites

* A running Prometheus and Alertmanager instance
* A PagerDuty account
* A PagerDuty service with an **Events V2 API integration key**

---

## 🔧 Step 1: Create PagerDuty Service Integration

1. Log in to [PagerDuty](https://pagerduty.com)
2. Go to **Services > Service Directory**
3. Click **+ Add New Service**
4. Name the service (e.g., `Prometheus Alerts`)
5. Set the **Integration Type** to **Prometheus** (Events API v2)
6. Save and copy the **Integration Key**

---

## 🛠 Step 2: Configure Alertmanager for PagerDuty

Edit your `alertmanager.yml`:

```yaml
global:
  resolve_timeout: 5m

route:
  receiver: 'pagerduty_notifications'

receivers:
  - name: 'pagerduty_notifications'
    pagerduty_configs:
      - routing_key: 'YOUR_PAGERDUTY_ROUTING_KEY_HERE'
        severity: '{{ .CommonLabels.severity }}'
        description: '{{ .CommonAnnotations.description }}'
        details:
          alertname: '{{ .CommonLabels.alertname }}'
          instance: '{{ .CommonLabels.instance }}'
```

🔁 Replace `routing_key` with your real integration key from PagerDuty.

---

## 🔄 Step 3: Reload Alertmanager

```bash
# If running as a service:
sudo systemctl restart alertmanager

# Or reload without restart:
curl -X POST http://localhost:9093/-/reload
```

---

## 📣 Step 4: Create a Sample Alert Rule in Prometheus

In your alert rules file:

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

## ✅ Result in PagerDuty

An **incident** will appear in PagerDuty’s dashboard with the summary:

```
The instance instance_ip:9100 is down.
```

Depending on escalation policy, it may notify via:

* Phone call
* SMS
* Email
* Mobile push

---

## 🧪 Testing

Check Alertmanager config with:

```bash
amtool check-config /etc/alertmanager/alertmanager.yml
```

---

## 📌 Notes

* `severity` can be mapped to `info`, `warning`, or `critical`
* Escalation policies are handled entirely by PagerDuty
* Supports deduplication, acknowledgment, and incident resolution via API

---

## 📚 Resources

* [Prometheus Alerting](https://prometheus.io/docs/alerting/latest/overview/)
* [PagerDuty Events API v2](https://developer.pagerduty.com/docs/events-api-v2/overview/)
* [Alertmanager Configuration](https://prometheus.io/docs/alerting/latest/configuration/)
