class AddTypeToClimbLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :climb_logs, :climb_type, :integer
  end
end
