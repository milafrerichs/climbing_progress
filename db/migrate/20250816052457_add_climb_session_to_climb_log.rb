class AddClimbSessionToClimbLog < ActiveRecord::Migration[8.0]
  def change
    add_reference :climb_logs, :climb_session, null: true, foreign_key: true
  end
end
