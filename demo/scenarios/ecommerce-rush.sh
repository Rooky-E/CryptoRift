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
