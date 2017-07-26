class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :desc
      t.references :profile, index: true

      t.timestamps null: false
    end
    add_foreign_key :categories, :profiles
  end
end
