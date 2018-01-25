class Geolocation < ApplicationRecord
  validates :message, presence: true
  validates :lat, presence:true, numericality: {only_float: true}
  validates :lng, presence:true, numericality: {only_float: true}
end
