class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :day
      t.date :date
      t.time :start_time
      t.references :activity, index: true
      t.references :membership, index: true

      t.timestamps null: false
    end
    add_foreign_key :schedules, :activities
    add_foreign_key :schedules, :memberships
  end
end
