#!/bin/bash
# 📸 Capture your StreamWave journey

DATE=$(date +%Y%m%d_%H%M%S)
CAPTURE_DIR="journey/screenshots/${DATE}"

mkdir -p "${CAPTURE_DIR}"

echo "📸 Capturing StreamWave state at ${DATE}..."

# Capture docker stats
docker stats --no-stream > "${CAPTURE_DIR}/docker_stats.txt"

# Capture topic info
docker exec kafka-broker kafka-topics --list --bootstrap-server localhost:9092 \
  > "${CAPTURE_DIR}/kafka_topics.txt" 2>/dev/null

echo "✅ Journey snapshot saved to ${CAPTURE_DIR}"
echo "📝 Add a note about this milestone:"
read -r note
echo "${note}" > "${CAPTURE_DIR}/note.txt"
