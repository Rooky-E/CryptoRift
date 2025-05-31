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
