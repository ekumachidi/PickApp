class Profile < ActiveRecord::Base
  belongs_to :user

  geocoded_by :address
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address
  
  validates :name,validates :recipient, format: {with: /[\w]+([\s]+[\w]+){1}+/,
                                       message: "Please fill in more than one name."}

  validates :address, presence: true

  validates :phone, presence: true,
                      format: {with: /\A0+[0-9]{9}/},
                      length:{maximum: 10, message:"number is too long. Maximum is 10 digits."}

end
