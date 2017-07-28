class CreateGcategories < ActiveRecord::Migration
  def change
    create_table :gcategories do |t|
      t.string :name
      t.string :desc
      t.references :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :gcategories, :groups
  end
end
