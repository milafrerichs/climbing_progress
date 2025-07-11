class ChangeClimbLogsGrade < ActiveRecord::Migration[8.0]
  def change
    reversible do |direction|
      change_table :climb_logs do |t|
        direction.up   { t.change :grade, 'decimal(4,2) USING (grade::numeric)' }
        direction.down { t.change :grade, :string }
      end
    end
  end
end
