class HomeController < ApplicationController
    @homepage = true
    def index
      # Eager load photos to prevent N+1 queries
      @top_cats = Cat.with_attached_photos.order(times_spotted: :desc).limit(3)

      # Get today's most spotted cat (seen within 24 hours)
      @king_block = Cat.where("last_seen >= ?", 24.hours.ago)
                      .order(times_spotted: :desc)
                      .first
    end

  def guidelines
  end
end
