class Cat < ApplicationRecord
    # Required fields with better error messages
    validates :name,
        presence: { message: "Every cat needs a name!" },
        length: { minimum: 2, too_short: "Name must be at least 2 characters" }

    validates :color,
        presence: { message: "Please describe the cat's color" }

    validates :location,
        presence: { message: "Where was this cat seen?" }

    validates :last_seen,
        presence: { message: "When was this cat last seen?" }

    validates :temperament,
        inclusion: {
        in: %w[Friendly Shy Playful Hungry Scared Skittish Mysterious Grumpy Cuddly],
        message: "%{value} is not a valid temperament. Choose from: Friendly, Shy, Playful, Hungry, Scared, Skittish, Mysterious, Grumpy, Cuddly"
        },
        allow_blank: true


    validates :pattern,
        length: { maximum: 50, too_long: "Pattern description is too long (max 50 characters)" },
        allow_blank: true

    validates :notes,
        length: { maximum: 500, too_long: "Notes are too long (max 500 characters)" },
        allow_blank: true

    def needs_feeding?
    last_fed_at.nil? || last_fed_at < 6.hours.ago
    end

    def fed_recently?
    return false if last_fed_at.nil?
    last_fed_at > 2.hours.ago
    end

    def time_since_last_fed
    return "Never fed" if last_fed_at.nil?

    seconds = Time.now - last_fed_at

    case
    when seconds < 60
        "just now"
    when seconds < 3600
        minutes = (seconds / 60).to_i
        "#{minutes} #{'minute'.pluralize(minutes)} ago"
    when seconds < 86400
        hours = (seconds / 3600).to_i
        "#{hours} #{'hour'.pluralize(hours)} ago"
    else
        days = (seconds / 86400).to_i
        "#{days} #{'day'.pluralize(days)} ago"
    end
    end

    def feed!
    update(
        last_fed_at: Time.now,
        times_fed_today: (last_fed_at&.today? ? times_fed_today + 1 : 1)
    )
    end

    def reset_daily_count
    update(times_fed_today: 0) unless last_fed_at&.today?
    end
end
