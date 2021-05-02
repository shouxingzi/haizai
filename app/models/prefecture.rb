class Prefecture < ApplicationRecord
  has_many :tweets
  has_many :cities
end
