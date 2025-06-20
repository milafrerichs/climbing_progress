class AddLocationReferenceToClimbLogs < ActiveRecord::Migration[8.0]
  def change
    add_reference :climb_logs, :location, foreign_key: true

    reversible do |dir|
      dir.up do
        ClimbLog.reset_column_information

        ClimbLog.find_each do |climb_log|
          location = Location.find_or_create_by(name: climb_log.location)
          climb_log.update_column(:location_id, location.id)
        end
      end

      dir.down do
        ClimbLog.reset_column_information

        ClimbLog.find_each do |climb_log|
          location = Location.find_by(id: climb_log.location_id)
          climb_log.update_column(:location, location&.name)
        end
      end
    end
    remove_column :climb_logs, :location, :string
  end
end
