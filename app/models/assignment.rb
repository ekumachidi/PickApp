class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :package
  belongs_to :courier
end
