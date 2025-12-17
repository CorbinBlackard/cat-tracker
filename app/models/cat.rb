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
end
