class Profile < ActiveRecord::Base
  # attr_accessor :address
  belongs_to :user

  geocoded_by :address
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude

  after_validation :reverse_geocode

  validates :name, format: {with: /[\w]+([\s]+[\w]+){1}+/, message: "Please fill in more than one name."}

  

  validates :phone, presence: true,
                      format: {with: /\A2|3|5+[0-9]{8}/},
                      length:{maximum: 9, message:"number is too long. Maximum is 9 digits."}



      

end
