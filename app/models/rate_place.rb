class RatePlace < ApplicationRecord
  belongs_to :user
  belongs_to :place

  validates :rate, presence: true
end
