# 🚀 Quick Start Guide

## Prerequisites
- Docker & Docker Compose
- 16GB RAM (minimum)
- 20GB free disk space

## 🎯 5-Minute Setup

### 1. Clone and Navigate
```bash
git clone https://github.com/Rooky-E/CryptoRift.git
cd streamwave
```

### 2. Launch the Stack
```bash
docker-compose up -d
```

### 3. Verify Services
```bash
docker-compose ps
```

All services should show as "running"!

## 🌊 First Steps

### Generate Your First Events
Events start flowing automatically! Check Kafka:
- Open http://localhost:9021
- Navigate to Topics → clickstream
- Click "Messages" to see live data

### Query Your Data
```bash
docker-compose exec trino trino
```

```sql
USE iceberg.db;
SELECT COUNT(*) FROM clickstream_sink;
```

## 🎨 Visualize
1. Open http://localhost:8088
2. Login: admin/admin
3. Go to Dashboards → StreamWave Analytics

Congratulations! You're streaming! 🎉
