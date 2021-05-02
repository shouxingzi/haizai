class Item < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  has_one :city through :prefecture
  has_many_attached :images

end
