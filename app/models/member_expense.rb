class MemberExpense < ActiveRecord::Base
  belongs_to :gexpense
  belongs_to :membership
end
