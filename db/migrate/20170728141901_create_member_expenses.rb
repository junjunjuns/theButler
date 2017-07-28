class CreateMemberExpenses < ActiveRecord::Migration
  def change
    create_table :member_expenses do |t|
      t.boolean :paid, :default => false
      t.references :gexpense, index: true
      t.references :membership, index: true

      t.timestamps null: false
    end
    add_foreign_key :member_expenses, :gexpenses
    add_foreign_key :member_expenses, :memberships
  end
end
