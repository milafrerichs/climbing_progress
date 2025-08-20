class CreateClimbSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :climb_sessions do |t|
      t.string :name
      t.datetime :start
      t.datetime :end
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
