class AddTimesSpottedToCats < ActiveRecord::Migration[8.0]
  def change
    add_column :cats, :times_spotted, :integer, default: 0, null: false
  end
end
