# README

# 🐱 Cat Tracker

A community-driven web application for tracking and caring for stray cats in apartment complexes and neighborhoods. Neighbors can collaboratively monitor local cats, track feedings, and share sightings.

## 🚀 Features

- **Cat Profiles**: Create detailed profiles for each community cat
- **Feeding Tracker**: Limit 3 feeds per cat daily, track last fed time
- **Sighting Log**: Record when and where cats are spotted
- **Community Dashboard**: See most spotted cats and recent activity
- **Responsive Design**: Works on desktop and mobile devices
- **No Login Required**: Simple, frictionless sharing for neighbors

## 🛠️ Tech Stack

- **Ruby 3.4.1**
- **Rails 8.0.4**
- **Bootstrap 5.3** - Styling and responsive design
- **Turbo/Hotwire** - Modern frontend interactions
- **SQLite** - Development database (production-ready for PostgreSQL)

## 📦 Installation

### Prerequisites

- Ruby 3.4.1
- Bundler gem
- Node.js & Yarn (for asset compilation)

### Setup

```bash
# Clone the repository
git clone <your-repo-url>
cd Cat_Tracker

# Install dependencies
bundle install
yarn install

# Set up the database
rails db:create
rails db:migrate

# Optional: Add sample data
rails db:seed

# Start the server
rails server
```

cats
├── id
├── name (required, min 2 chars)
├── color (required)
├── pattern (optional, max 50 chars)
├── temperament (Friendly/Shy/Playful/Hungry/Scared/Skittish/Mysterious/Grumpy/Cuddly)
├── location (required)
├── last_seen (required, datetime)
├── notes (optional, max 500 chars)
├── favorite_food (min 2 chars)
├── times_spotted (default: 0, tracks sightings)
├── times_fed_today (default: 0, resets daily)
├── last_fed_at (datetime)
├── created_at
└── updated_at
