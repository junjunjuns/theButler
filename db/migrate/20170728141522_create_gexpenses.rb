class CreateGexpenses < ActiveRecord::Migration
  def change
    create_table :gexpenses do |t|
      t.date :paid_on
      t.decimal :total_amt
      t.decimal :shared_amt
      t.references :profile, index: true
      t.references :group, index: true
      t.references :gitem, index: true

      t.timestamps null: false
    end
    add_foreign_key :gexpenses, :profiles
    add_foreign_key :gexpenses, :groups
    add_foreign_key :gexpenses, :gitems
  end
end
