class Schedule < ActiveRecord::Base
  belongs_to :activity
  belongs_to :membership
end
