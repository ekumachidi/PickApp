class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :package
 
  validates :package_id,uniqueness: {message: 'package has already been assigned'} 
end
