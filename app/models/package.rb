class Package < ActiveRecord::Base
  belongs_to :user
  has_one :assignments
  
  
  geocoded_by :location
  after_validation :geocode

  #reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  before_create :generate_ref_code, unless: :ref_code?

  private
    def generate_ref_code
		self.ref_code = SecureRandom.hex(3) #for 6 characters long codes
    end

  validates :tracking_code, presence:true,
  						  uniqueness: true

  validates :vendor, presence: true

  validates :weight, inclusion:{in: 1..50 , message: "weight must be from 1kg to 50kg"},
  					  presence: true
 
  validates :recipient, format: {with: /[\w]+([\s]+[\w]+){1}+/, message: "Please fill in more than one name."}

  validates :r_contact, presence: true,
                    format: {with: /\A2|3|5+[0-9]{8}/},
                    length:{maximum: 9, message:"number is too long. Maximum is 9 digits."}



end
