class Profile < ActiveRecord::Base
  belongs_to :user

  geocoded_by :location
  after_validation :geocode
  
  validates :name,validates :recipient, format: {with: /[\w]+([\s]+[\w]+){1}+/,
                                       message: "Please fill in more than one name."}

  validates :address, presence: true

  validates :phone, presence: true,
                      format: {with: /\A0+[0-9]{9}/},
                      length:{maximum: 10, message:"number is too long. Maximum is 10 digits."}

end
