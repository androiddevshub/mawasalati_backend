class Booking < ApplicationRecord
  has_many :passengers
  belongs_to :user
end
