# PromQL Data Types: Scalars, Instant Vectors, and Range Vectors

Prometheus provides a powerful query language called **PromQL**, which works on different **data types** used to retrieve and manipulate time series data.

This repo explains the key data types: `scalar`, `instant vector`, and `range vector`, with practical examples and use cases.

---

## 📚 Data Types Overview

| Type               | Description                                         | Example                         |
| ------------------ | --------------------------------------------------- | ------------------------------- |
| **Scalar**         | A single numeric value (floating point)             | `5 * 60`                        |
| **Instant Vector** | Set of time series with the latest value per series | `up`, `http_requests_total`     |
| **Range Vector**   | Set of time series with values over a time window   | `rate(http_requests_total[5m])` |

---

## 🔢 1. Scalar

* **Scalar** is just a number.
* Useful for scaling results or performing mathematical operations.

### 🔍 Example:

```promql
5 * 60
```

Returns:

```
300
```

### 🧠 Use Case:

Convert minutes to seconds, or multiply results:

```promql
rate(http_requests_total[5m]) * 60
```

---

## ⚡ 2. Instant Vector

* Represents a snapshot of time series data **at a single point in time**.

### 🔍 Example:

```promql
up
```

Returns:

```
up{job="node", instance="localhost:9100"} = 1
```

### 🔍 Example with labels:

```promql
node_memory_Active_bytes{instance="localhost:9100"}
```

Returns memory usage from a specific instance.

### 🧠 Use Case:

Used to compare or filter time series metrics at the current timestamp.

---

## ⏱️ 3. Range Vector

* Represents values from a time series over a **time range**.
* Used for aggregation and rate calculations.

### 🔍 Example:

```promql
rate(http_requests_total[5m])
```

Returns per-second request rate over last 5 minutes.

### 🔍 Example:

```promql
avg_over_time(node_load1[1h])
```

Returns the average 1-minute load over the last hour.

### 🧠 Use Case:

Analyze trends over time (e.g., averages, maxima, rate of change).

---
## 🧪 Try These Queries

Try these directly in Prometheus expression browser:

```promql
1 / 3
node_cpu_seconds_total
node_filesystem_free_bytes{mountpoint="/"}
rate(node_network_receive_bytes_total[1m])
avg_over_time(node_memory_Active_bytes[10m])
```

---

## 🔗 Resources

* 📘 [Prometheus Data Types Docs](https://prometheus.io/docs/prometheus/latest/querying/basics/)
* 🧠 [PromQL Examples](https://prometheus.io/docs/prometheus/latest/querying/examples/)
* 📘 [Grafana for Prometheus](https://grafana.com/docs/grafana/latest/datasources/prometheus/)
