class HomeController < ApplicationController
  def index
    # Eager load photos
    @top_cats = Cat.with_attached_photos
                  .where("last_seen >= ?", 24.hours.ago)
                  .order(times_spotted: :desc)
                  .limit(3)

    # Today's most spotted cat
    @king_block = Cat.where("last_seen >= ?", 24.hours.ago)
                    .order(times_spotted: :desc)
                    .first
  end

  def guidelines
  end
end
