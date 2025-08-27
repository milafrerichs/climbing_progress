class CreateLocationAreas < ActiveRecord::Migration[8.0]
  def change
    create_table :location_areas do |t|
      t.string :name
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
