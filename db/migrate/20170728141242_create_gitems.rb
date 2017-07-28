class CreateGitems < ActiveRecord::Migration
  def change
    create_table :gitems do |t|
      t.string :name
      t.string :desc
      t.references :gcategory, index: true

      t.timestamps null: false
    end
    add_foreign_key :gitems, :gcategories
  end
end
