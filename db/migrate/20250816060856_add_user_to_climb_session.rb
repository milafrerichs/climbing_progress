class AddUserToClimbSession < ActiveRecord::Migration[8.0]
  def change
    add_reference :climb_sessions, :user, null: false, foreign_key: true
  end
end
