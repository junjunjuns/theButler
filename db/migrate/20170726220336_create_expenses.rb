class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.date :exp_date
      t.decimal :amt
      t.references :profile, index: true
      t.references :item, index: true

      t.timestamps null: false
    end
    add_foreign_key :expenses, :profiles
    add_foreign_key :expenses, :items
  end
end
