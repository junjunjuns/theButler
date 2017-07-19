class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.references :group, index: true
      t.references :profile, index: true

      t.timestamps null: false
    end
    add_foreign_key :messages, :groups
    add_foreign_key :messages, :profiles
  end
end
