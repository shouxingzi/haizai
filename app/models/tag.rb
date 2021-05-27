class Tag < ApplicationRecord
  has_many :tweet_tag_rerations
  has_many :tweets, through: :tweet_tag_relations

  validates :name, uniqueness: true
  # uniqueの設定はモデル単位で設定する必要があるためformオブジェクトで設定しないでこちらで設定する
end