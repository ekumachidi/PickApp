class Package < ActiveRecord::Base
  belongs_to :user
  
  geocoded_by :location
  after_validation :geocode

  before_create :generate_ref_code, unless: :ref_code?

  private
    def generate_ref_code
		self.ref_code = SecureRandom.hex(3) #for 6 characters long codes
    end
end
