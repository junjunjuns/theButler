class RemoveAgeFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :age, :integer
    add_column :profiles, :dob, :date
  end
end
