# 🔍 Common Issues & Solutions

## 🐳 Docker Issues

### "Cannot connect to Docker daemon"
```bash
# Ensure Docker is running
sudo systemctl start docker
# Or on Mac/Windows, start Docker Desktop
```

### "Port already in use"
```bash
# Find what's using the port (e.g., 9092)
lsof -i :9092
# Kill the process or change ports in docker-compose.yml
```

## 📊 Service-Specific Issues

### Kafka Not Starting
- **Check logs**: `docker-compose logs kafka`
- **Common fix**: Ensure Zookeeper is healthy first
- **Memory issue**: Increase Docker memory to 8GB+

### Flink Job Not Running
- **Check JobManager**: http://localhost:18081
- **Common causes**:
  - SQL syntax error in clickstream-filtering.sql
  - Kafka topic doesn't exist yet
  - Insufficient TaskManager slots

### Trino Queries Failing
- **"Table not found"**: Wait for Flink to create tables
- **"No nodes available"**: Check Trino worker health
- **Slow queries**: Check MinIO connectivity

### Superset Connection Issues
- **"Cannot connect to database"**:
  ```
  SQLAlchemy URI: trino://trino@trino:8080/iceberg/db
  ```
- **No data showing**: Ensure Flink job is processing events

## 🆘 Emergency Commands

### Full Reset
```bash
docker-compose down -v
docker-compose up -d --force-recreate
```

### Check All Logs
```bash
docker-compose logs -f
```

### Service Health Check
```bash
for service in kafka flink-jobmanager trino superset; do
  echo "Checking $service..."
  docker-compose ps $service
done
```
