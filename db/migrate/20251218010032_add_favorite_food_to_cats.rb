class AddFavoriteFoodToCats < ActiveRecord::Migration[8.0]
  def change
    add_column :cats, :favorite_food, :string
  end
end
