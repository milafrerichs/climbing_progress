class CreateClimbLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :climb_logs do |t|
      t.date :date
      t.string :location
      t.string :route_name
      t.string :grade
      t.string :status
      t.text :notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
