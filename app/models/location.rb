class Location < ApplicationRecord
  has_many :climb_logs
  validates :name, presence: true, uniqueness: true
end
