json.extract! cat, :id, :name, :color, :pattern, :temperament, :location, :last_seen, :notes, :created_at, :updated_at
json.url cat_url(cat, format: :json)
