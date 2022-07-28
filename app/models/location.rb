class Location < ApplicationRecord
  belongs_to :user
  geocoded_by :address
  after_validation :geocode

  validates :street, presence: :true
  validates :city, presence: :true
  validates :state, presence: :true
  validates :country, presence: :true

  def address
    [street, city, state, country].compact.join(", ")
  end

  def coordinates
    [self.latitude, self.longitude]
  end
end
