class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  belongs_to :city
  has_one_attached :image
  has_many :rooms, dependent: :destroy
  has_many :tweet_tag_relations, dependent: :destroy
  has_many :tags, through: :tweet_tag_relations
end
