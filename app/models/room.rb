class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users, validate: false
  has_many :messages, dependent: :destroy
  belongs_to :tweet
  
  with_options presence: true do
    validates :room_name
  end
end
