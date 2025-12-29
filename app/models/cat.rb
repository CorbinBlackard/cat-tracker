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

   validates :favorite_food,
         length: { minimum: 2, too_short: "Food must be at least 2 characters" }

   validates :times_spotted,
         numericality: {
         only_integer: true,
         greater_than_or_equal_to: 0,
         message: "must be non-negative number"
         }, allow_blank: true

   has_many_attached :photos
   validate :validate_photos


   # def self.missing_cats
   #    Cat.where("last_seen < ? OR last_seen IS NULL", 48.hours.ago)
   # end

   # Using scope instead of self.missing_cats method
   scope :missing, -> { where("last_seen < ? OR last_seen IS NULL", 48.hours.ago) }

   def spotted!
      if last_seen.nil? || last_seen < 24.hours.ago
         self.times_spotted = 0
      end

      self.times_spotted += 1
      self.last_seen = Time.now
      save
   end

   def todays_spottings
      if last_seen && last_seen >= 24.hours.ago
         times_spotted
      else
         0
      end
   end

   def reset_spots
      update(times_spotted: 0)
   end

   def repair_feeding_data!
      # If data looks broken, fix it
      if times_fed_today > 3 || (last_fed_at.nil? && times_fed_today > 0)
      update(
      times_fed_today: 0,
      last_fed_at: nil
      )
      puts "Repaired #{name}'s feeding data"
      end
   end

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

   def reset_daily_count_if_needed
      # Always reset if times_fed_today is 3 and it's a new day
      if times_fed_today >= 3 && (last_fed_at.nil? || last_fed_at < 24.hours.ago)
      update(times_fed_today: 0)
      true
      elsif last_fed_at.nil? || last_fed_at < 24.hours.ago
      update(times_fed_today: 0)
      true
      else
      false
      end
   end

   def can_be_fed_today?
      reset_daily_count_if_needed
      times_fed_today < 3
   end

   def daily_feeds_remaining
      reset_daily_count_if_needed
      3 - times_fed_today
   end

   def feed!
      # ALWAYS reset if needed before checking
      reset_daily_count_if_needed

      if times_fed_today >= 3
      errors.add(:base, "#{name} has already been fed 3 times today!")
      return false
      end

      update(
      last_fed_at: Time.current,
      times_fed_today: times_fed_today + 1
      )
   end

   def reset_daily_count
         update(times_fed_today: 0)
   end

   def missing_cat?
      last_seen.nil? || last_seen < 48.hours.ago
   end


   private
   # In app/models/cat.rb, update validate_photos:

   def validate_photos
      return unless photos.attached?

      photos.each do |photo|
         # Check size
         if photo.blob.byte_size > 5.megabytes
            errors.add(:photos, "#{photo.filename} is too large (max 5MB)")
         end

         # REJECT HEIC files
         if photo.blob.content_type == "image/heic"
            errors.add(:photos, "#{photo.filename} is HEIC format. Please convert to JPEG or PNG first.")
         end

         # Only accept browser-displayable formats
         unless photo.blob.content_type.in?(%w[image/jpeg image/jpg image/png image/gif image/webp])
            errors.add(:photos, "#{photo.filename} must be JPEG, PNG, GIF, or WebP")
         end
      end
   end
end
