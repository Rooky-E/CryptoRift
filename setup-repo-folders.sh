#!/bin/bash

# 🎯 Professional StreamWave Repo Setup
# These folders add value for users and contributors

echo "📦 Setting up professional repo structure..."

# 1. 📚 Documentation
echo "Creating documentation structure..."
mkdir -p docs/{setup-guides,tutorials,api-reference,troubleshooting}

cat > docs/README.md << 'EOF'
# 📚 StreamWave Documentation

Welcome to the StreamWave documentation! Here you'll find everything you need to master real-time data streaming.

## 📁 Documentation Structure

### 🔧 [Setup Guides](./setup-guides/)
- [Quick Start Guide](./setup-guides/quick-start.md)
- [Production Setup](./setup-guides/production.md)
- [Configuration Reference](./setup-guides/configuration.md)

### 🎓 [Tutorials](./tutorials/)
- [Your First Stream](./tutorials/01-first-stream.md)
- [Building Custom Processors](./tutorials/02-custom-processors.md)
- [Advanced Querying](./tutorials/03-advanced-queries.md)

### 📖 [API Reference](./api-reference/)
- [Kafka Topics](./api-reference/kafka-topics.md)
- [Flink Jobs](./api-reference/flink-jobs.md)
- [Trino Queries](./api-reference/trino-queries.md)

### 🔍 [Troubleshooting](./troubleshooting/)
- [Common Issues](./troubleshooting/common-issues.md)
- [Performance Tuning](./troubleshooting/performance.md)
- [FAQ](./troubleshooting/faq.md)
EOF

cat > docs/setup-guides/quick-start.md << 'EOF'
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
EOF

cat > docs/tutorials/01-first-stream.md << 'EOF'
# 🌊 Tutorial: Your First Stream

## Learning Objectives
- Understand the data flow
- Create a custom event
- Process it through the pipeline
- Query the results

## Step 1: Understanding the Flow

```
Producer → Kafka → Flink → Iceberg → Trino → Superset
```

## Step 2: Create a Custom Event

Connect to the producer:
```bash
docker-compose exec producer bash
```

Create a test event:
```python
python -c "
import json
from kafka import KafkaProducer

producer = KafkaProducer(
    bootstrap_servers=['kafka:9092'],
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

event = {
    'event_id': 'tutorial-001',
    'user_id': 'student-1',
    'event_type': 'tutorial_complete',
    'timestamp': '2025-01-01T12:00:00Z'
}

producer.send('clickstream', event)
producer.flush()
print('🎉 Event sent!')
"
```

## Step 3: Watch it Flow

### In Kafka:
Check http://localhost:9021 → Topics → clickstream

### In Flink:
Check http://localhost:18081 → Running Jobs

### In Trino:
```sql
SELECT * FROM iceberg.db.clickstream_sink 
WHERE event_id = 'tutorial-001';
```

## 🎯 Challenge
Modify the Flink job to filter only 'tutorial_complete' events!
EOF

cat > docs/troubleshooting/common-issues.md << 'EOF'
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
EOF

# 2. 🎮 Demo Data & Scenarios
echo "Creating demo scenarios..."
mkdir -p demo/{sample-data,scenarios,notebooks}

cat > demo/README.md << 'EOF'
# 🎮 StreamWave Demo Scenarios

Experience StreamWave with pre-built scenarios and sample data!

## 🎯 Available Demos

### 1. E-Commerce Rush
Simulate Black Friday traffic with millions of events
```bash
./scenarios/ecommerce-rush.sh
```

### 2. Gaming Platform
Track player actions in a multiplayer game
```bash
./scenarios/gaming-platform.sh
```

### 3. IoT Sensor Network
Process sensor data from smart city infrastructure
```bash
./scenarios/iot-sensors.sh
```

## 📊 Sample Datasets

- `sample-data/small-batch.json` - 1K events for testing
- `sample-data/medium-load.json` - 100K events for development  
- `sample-data/stress-test.json` - 10M events for benchmarking

## 📓 Jupyter Notebooks

Interactive notebooks for data exploration:
- `notebooks/data-exploration.ipynb`
- `notebooks/performance-analysis.ipynb`
- `notebooks/ml-pipeline-demo.ipynb`
EOF

cat > demo/scenarios/ecommerce-rush.sh << 'EOF'
#!/bin/bash
# 🛍️ E-Commerce Rush Scenario

echo "🛍️ Starting Black Friday simulation..."
echo "📊 Generating 1M shopping events over 60 seconds"

docker-compose exec producer python -c "
import time
import json
import random
from datetime import datetime
from kafka import KafkaProducer
from faker import Faker

fake = Faker()
producer = KafkaProducer(
    bootstrap_servers=['kafka:9092'],
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

products = ['iPhone', 'MacBook', 'AirPods', 'iPad', 'Watch']
event_types = ['view', 'add_to_cart', 'purchase', 'remove_from_cart']

start_time = time.time()
events_sent = 0

while time.time() - start_time < 60:
    event = {
        'event_id': fake.uuid4(),
        'user_id': f'user_{random.randint(1, 10000)}',
        'event_type': random.choice(event_types),
        'product': random.choice(products),
        'price': round(random.uniform(50, 2000), 2),
        'timestamp': datetime.utcnow().isoformat()
    }
    
    producer.send('clickstream', event)
    events_sent += 1
    
    if events_sent % 10000 == 0:
        print(f'🚀 Sent {events_sent} events...')
    
    time.sleep(0.00006)  # ~16K events/second

producer.flush()
print(f'✅ Black Friday simulation complete! Sent {events_sent} events')
"
EOF

chmod +x demo/scenarios/ecommerce-rush.sh

# 3. 🎨 Assets
echo "Creating assets structure..."
mkdir -p assets/{logos,banners,diagrams,screenshots}

cat > assets/README.md << 'EOF'
# 🎨 StreamWave Visual Assets

## 🖼️ Available Assets

### Logos
- `logos/streamwave-logo.svg` - Main logo (vector)
- `logos/streamwave-icon.png` - App icon (512x512)
- `logos/streamwave-banner.png` - GitHub banner (1280x640)

### Architecture Diagrams
- `diagrams/architecture-overview.png` - High-level view
- `diagrams/data-flow.svg` - Detailed data flow
- `diagrams/deployment.png` - Deployment architecture

### Screenshots
- `screenshots/dashboard.png` - Superset dashboard
- `screenshots/flink-ui.png` - Flink monitoring
- `screenshots/kafka-topics.png` - Kafka control center

## 🎨 Brand Guidelines

### Colors
- Primary: `#3a86ff` (Electric Blue)
- Secondary: `#ff006e` (Stream Pink)
- Success: `#06ffa5` (Data Green)
- Background: `#0a0e27` (Deep Ocean)

### Typography
- Headers: Montserrat Bold
- Body: Inter Regular
- Code: JetBrains Mono

### Usage
Feel free to use these assets for:
- Presentations
- Blog posts  
- Documentation
- Social media

Licensed under CC BY 4.0
EOF

# 4. 🌈 Welcome Experience (already exists, just enhance)
cat > welcome/first-time-setup.md << 'EOF'
# 🎉 Welcome to StreamWave!

## 🏃 Quick Start Checklist

- [ ] Docker installed and running
- [ ] Cloned the repository
- [ ] Run `docker-compose up -d`
- [ ] All services are green in `docker ps`
- [ ] Accessed Kafka UI at http://localhost:9021
- [ ] Saw your first events flowing
- [ ] Ran your first Trino query
- [ ] Viewed Superset dashboard

## 🎯 What's Next?

1. **Run a demo scenario**
   ```bash
   ./demo/scenarios/ecommerce-rush.sh
   ```

2. **Explore the tutorials**
   Start with [Your First Stream](../docs/tutorials/01-first-stream.md)

3. **Join the community**
   - ⭐ Star the repo
   - 🐛 Report issues
   - 💡 Suggest features

## 🆘 Need Help?

- Check [Common Issues](../docs/troubleshooting/common-issues.md)
- Review the [FAQ](../docs/troubleshooting/faq.md)
- Open an issue on GitHub

Happy Streaming! 🌊
EOF

# 5. Create .gitignore for repo
cat > .gitignore << 'EOF'
# StreamWave GitIgnore

# Personal/Local folders
achievements/
journey/screenshots/
.future/
.streamwave/
*.log

# Docker volumes
data/
logs/
checkpoints/

# OS files
.DS_Store
Thumbs.db

# IDE
.idea/
.vscode/
*.swp

# Python
__pycache__/
*.pyc
.env
venv/

# Keep folder structure
!.gitkeep
!*/README.md
EOF

# 6. Add .gitkeep files to empty directories
find . -type d -empty -not -path "./.git/*" -exec touch {}/.gitkeep \;

echo ""
echo "✅ ================================== ✅"
echo "   📦 Professional repo structure created!"
echo "✅ ================================== ✅"
echo ""
echo "📁 Added for your repo:"
echo "  ✓ docs/       - Comprehensive documentation"
echo "  ✓ demo/       - Sample scenarios & data"
echo "  ✓ assets/     - Logos & diagrams"
echo "  ✓ welcome/    - First-time user experience"
echo "  ✓ .gitignore  - Proper exclusions"
echo ""
echo "🎯 These folders ADD VALUE for users!"
echo "🚀 Your repo is now professional AND magical!"
