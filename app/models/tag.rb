class Tag < ApplicationRecord
  has_many :tweet_tag_rerations
  has_many :tweets, through: :tweet_tag_relations

  # uniqueの設定はモデル単位で設定する必要があるためformオブジェクトで設定しないでこちらで設定する
  # case_sensitive: false  大文字小文字を区別しない
  validates :name, uniqueness: { case_sensitive:  false }

end
