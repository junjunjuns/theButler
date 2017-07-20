class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.references :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :activities, :groups
  end
end
