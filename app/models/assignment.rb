class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :package
  belongs_to :courier

  validates :package_id, uniqueness: true {message: 'package has already been assigned'}
end
