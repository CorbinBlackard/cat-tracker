class CreateCats < ActiveRecord::Migration[8.0]
  def change
    create_table :cats do |t|
      t.string :name
      t.string :color
      t.string :pattern
      t.string :temperament
      t.string :location
      t.datetime :last_seen
      t.text :notes

      t.timestamps
    end
  end
end
