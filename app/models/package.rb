class Package < ActiveRecord::Base
  belongs_to :user
  
  geocoded_by :location
  after_validation :geocode

  before_create :generate_token, unless: :token?

  private
    def generate_token
	self.token = SecureRandom.hex(3) #for 6 characters long codes
    end
end
