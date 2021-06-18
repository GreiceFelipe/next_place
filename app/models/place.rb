class Place < ApplicationRecord
  validates :maps_id, presence: true
  validates :name, presence: true
  validates :url, presence: true
  validates :address, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  validates :maps_id, uniqueness: true

  belongs_to :user
end
