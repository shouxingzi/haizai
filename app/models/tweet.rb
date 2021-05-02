class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  belongs_to :city
  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :text
    validates :prefecture_id
    validates :city_id
    validates :user_id
  end
end
