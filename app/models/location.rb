class Location < ApplicationRecord
  has_many :climb_logs
  has_many :location_areas
  validates :name, presence: true, uniqueness: true
end
