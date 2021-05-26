class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  belongs_to :city
  has_one_attached :image
  has_many :rooms, dependent: :destroy
  has_many :tweet_tag_relations, dependent: :destroy
  has_many :tags, through: :tweet_tag_relations


  # with_options presence: true do
  #   validates :title
  #   validates :text
  #   validates :prefecture_id
  #   validates :city_id
  #   validates :user_id
  # end
end
