class UpdateUsers < ActiveRecord::Migration
  def change
    @u= User.find_by(email: 'butler@butler.com')
    # If there is no user with the email butler@butler.com
    # The find_by method above will return nil
    # nil shows that there is no record with that email
    
    if @u != nil
      # Set admin to true if a user with that email is found
      @u.update_attribute :admin, true
    end
  end
end
