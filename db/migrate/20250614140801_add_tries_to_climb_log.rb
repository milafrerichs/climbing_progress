class AddTriesToClimbLog < ActiveRecord::Migration[8.0]
  def change
    add_column :climb_logs, :tries, :integer
  end
end
