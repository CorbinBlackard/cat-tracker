class AddFeedingInfoToCats < ActiveRecord::Migration[8.0]
  def change
    add_column :cats, :last_fed_at, :datetime
    add_column :cats, :times_fed_today, :integer, default: 0
  end
end
