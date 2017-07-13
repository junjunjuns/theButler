class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.timestamps :accepted_on
      t.boolean :g_admin, :default => false
      t.references :profile, index: true
      t.references :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :memberships, :profiles
    add_foreign_key :memberships, :groups
  end
end
