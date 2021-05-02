class Item < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  has_one :city through :prefecture
  has_many_attached :images

  with_options presence: true do
    validates  :item
    validates  :description
    validates  :prefecture_id
    validates  :city_id
    validates  :user_id
  end
end
