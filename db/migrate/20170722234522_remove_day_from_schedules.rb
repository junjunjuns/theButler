class RemoveDayFromSchedules < ActiveRecord::Migration
  def change
    remove_column :schedules, :day, :string
  end
end
