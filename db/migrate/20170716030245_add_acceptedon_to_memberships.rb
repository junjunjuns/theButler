class AddAcceptedonToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :accepted_on, :datetime
  end
end
