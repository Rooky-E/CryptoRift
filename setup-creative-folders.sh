#!/bin/bash

# 🎨 StreamWave Creative Folders Setup Script
# Run this in your project root to add magical folders!

echo "🌊 Setting up StreamWave creative folders..."

# 1. 🌈 Welcome Experience
echo "Creating Welcome Experience..."
mkdir -p welcome/ascii-art
cat > welcome/ascii-art/streamwave.txt << 'EOF'
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║   ███████╗████████╗██████╗ ███████╗ █████╗ ███╗   ███╗      ║
║   ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗████╗ ████║      ║
║   ███████╗   ██║   ██████╔╝█████╗  ███████║██╔████╔██║      ║
║   ╚════██║   ██║   ██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║      ║
║   ███████║   ██║   ██║  ██║███████╗██║  ██║██║ ╚═╝ ██║      ║
║   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝      ║
║                                                              ║
║            🌊 Welcome to the Data Stream 🌊                  ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
EOF

cat > welcome/README.md << 'EOF'
# 🌈 Welcome to StreamWave!

## 🎯 Quick Start Ritual

1. **🎪 Raise the Curtain**
   ```bash
   docker-compose up -d
   ```

2. **🎭 Watch the Magic**
   ```bash
   docker-compose logs -f
   ```

3. **🌊 Surf the Streams**
   - Kafka UI: http://localhost:9021
   - Flink Dashboard: http://localhost:18081
   - Superset: http://localhost:8088

## 🎨 ASCII Art Collection
Check out our ASCII art collection in the `ascii-art/` folder!

May your streams flow eternal! 🚀
EOF

# 2. 🎮 Gamification System
echo "Setting up Gamification System..."
mkdir -p achievements/badges achievements/milestones

cat > achievements/badges/badges.json << 'EOF'
{
  "badges": [
    {
      "id": "first_stream",
      "name": "🌊 First Wave",
      "description": "Successfully processed your first event stream",
      "icon": "🌊",
      "unlocked": false
    },
    {
      "id": "million_events",
      "name": "🚀 Data Astronaut",
      "description": "Processed 1 million events",
      "icon": "🚀",
      "unlocked": false
    },
    {
      "id": "speed_demon",
      "name": "⚡ Speed Demon",
      "description": "Achieved 10k events/second throughput",
      "icon": "⚡",
      "unlocked": false
    },
    {
      "id": "uptime_warrior",
      "name": "🛡️ Uptime Warrior",
      "description": "7 days continuous operation",
      "icon": "🛡️",
      "unlocked": false
    },
    {
      "id": "query_master",
      "name": "🦅 Query Eagle",
      "description": "Executed a query under 100ms on 1TB data",
      "icon": "🦅",
      "unlocked": false
    }
  ]
}
EOF

cat > achievements/track_progress.sh << 'EOF'
#!/bin/bash
# 🎮 Achievement Tracker

EVENTS_PROCESSED=$(docker exec kafka-broker kafka-run-class kafka.tools.GetOffsetShell \
  --broker-list localhost:9092 --topic clickstream --time -1 2>/dev/null | \
  awk -F: '{sum += $3} END {print sum}')

echo "📊 StreamWave Progress Report"
echo "=============================="
echo "🌊 Events Processed: ${EVENTS_PROCESSED:-0}"
echo ""
echo "🏆 Achievements:"

if [ "${EVENTS_PROCESSED:-0}" -gt 0 ]; then
  echo "✅ 🌊 First Wave - UNLOCKED!"
fi

if [ "${EVENTS_PROCESSED:-0}" -gt 1000000 ]; then
  echo "✅ 🚀 Data Astronaut - UNLOCKED!"
fi

echo ""
echo "Keep streaming to unlock more badges! 🎯"
EOF

chmod +x achievements/track_progress.sh

# 3. 📸 Visual Journey
echo "Creating Visual Journey..."
mkdir -p journey/screenshots journey/milestones

cat > journey/capture.sh << 'EOF'
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
EOF

chmod +x journey/capture.sh

# 4. 🔮 Future Dreams
echo "Creating Future Dreams..."
mkdir -p .future/2025-dreams .future/ideas

cat > .future/2025-dreams/ROADMAP.md << 'EOF'
# 🔮 StreamWave Future Dreams

## 🌟 Q1 2025 - The Awakening
- [ ] 🤖 ML-powered anomaly detection
- [ ] 🌍 Multi-region replication
- [ ] 📊 Advanced visualization themes

## 🚀 Q2 2025 - The Acceleration  
- [ ] 🔥 10x performance boost
- [ ] 🧪 A/B testing framework
- [ ] 🎨 Custom dashboard builder

## 🌌 Q3 2025 - The Expansion
- [ ] ☁️ Cloud-native deployment
- [ ] 🔐 Enterprise security features
- [ ] 🌐 GraphQL API

## 🎯 Q4 2025 - The Revolution
- [ ] 🧠 AI-driven insights
- [ ] 🌊 Real-time data lake
- [ ] 🎮 Interactive data playground

## 💭 Wild Ideas Parking Lot
- Holographic data visualization? 🎭
- Quantum computing integration? ⚛️
- Stream processing in space? 🛸
EOF

# 5. 🎁 Hidden Magic
echo "Adding hidden magic..."
mkdir -p .streamwave/easter-eggs .streamwave/themes

cat > .streamwave/easter-eggs/konami.js << 'EOF'
// 🎮 Konami Code Easter Egg
// Add this to Superset for fun!

const konamiCode = ['ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown', 
                   'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight', 
                   'b', 'a'];
let konamiIndex = 0;

document.addEventListener('keydown', (e) => {
  if (e.key === konamiCode[konamiIndex]) {
    konamiIndex++;
    if (konamiIndex === konamiCode.length) {
      alert('🌊 UNLIMITED STREAMS UNLOCKED! 🌊');
      document.body.style.animation = 'rainbow 2s infinite';
      konamiIndex = 0;
    }
  } else {
    konamiIndex = 0;
  }
});
EOF

cat > .streamwave/themes/cyberpunk.css << 'EOF'
/* 🌆 Cyberpunk StreamWave Theme */
:root {
  --neon-pink: #ff006e;
  --neon-blue: #3a86ff;
  --neon-purple: #8338ec;
  --dark-bg: #0a0a0a;
}

.streamwave-cyberpunk {
  background: var(--dark-bg);
  color: var(--neon-blue);
  text-shadow: 0 0 10px currentColor;
}

.neon-glow {
  box-shadow: 
    0 0 20px var(--neon-pink),
    0 0 40px var(--neon-blue),
    0 0 60px var(--neon-purple);
}
EOF

# 6. 🎨 Assets Organization
echo "Organizing assets..."
mkdir -p assets/banners assets/logos assets/diagrams

cat > assets/README.md << 'EOF'
# 🎨 StreamWave Visual Assets

## 📁 Directory Structure

- **🖼️ banners/** - README headers, social media banners
- **🎯 logos/** - StreamWave logos in various formats
- **📊 diagrams/** - Architecture and flow diagrams

## 🎨 Brand Colors

- Primary: `#3a86ff` (Electric Blue) 🔵
- Secondary: `#ff006e` (Neon Pink) 🩷
- Accent: `#8338ec` (Cosmic Purple) 🟣
- Success: `#06ffa5` (Matrix Green) 🟢

## 🌊 Design Philosophy

> "Flow like water, strike like lightning"

Our visuals should evoke:
- 🌊 Fluidity of data streams
- ⚡ Speed of processing
- 🌌 Vastness of possibilities
EOF

# 7. Create .gitkeep files
echo "Adding .gitkeep files..."
find . -type d -empty -not -path "./.git/*" -exec touch {}/.gitkeep \;

# 8. Final summary script
cat > explore.sh << 'EOF'
#!/bin/bash
# 🗺️ Explore StreamWave's magical folders

echo "🌊 StreamWave Directory Explorer 🌊"
echo "==================================="
echo ""
echo "🎪 Core Components:"
ls -la | grep -E "flink|producer|superset|trino|docker"
echo ""
echo "✨ Creative Additions:"
ls -la | grep -E "welcome|achievements|journey|assets"
echo ""
echo "🔮 Hidden Treasures:"
ls -la .* 2>/dev/null | grep -E "future|streamwave"
echo ""
echo "💡 Try these commands:"
echo "  ./achievements/track_progress.sh  - Check your achievements"
echo "  ./journey/capture.sh             - Capture a milestone"
echo "  cat welcome/ascii-art/*          - View ASCII art"
echo ""
EOF

chmod +x explore.sh

echo ""
echo "✨ ================================== ✨"
echo "   🎉 Creative folders created! 🎉"
echo "✨ ================================== ✨"
echo ""
echo "🎯 Next steps:"
echo "  1. Run './explore.sh' to see your new structure"
echo "  2. Check out the welcome folder for quick start"
echo "  3. Track your progress with achievements"
echo "  4. Document your journey with screenshots"
echo ""
echo "🌊 May your streams flow eternal! 🌊"
