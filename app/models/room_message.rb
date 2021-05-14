class RoomMessage
  include ActiveModel::Model
  attr_accessor :room_name, :tweet_id, :content, :room_id, :user_id, :user_ids[]

  validates :room_name, presence: true
  validates :content, presence: true

  def save
    room = Room.create(room_name: room_name, tweet_id: tweet_id, )
    RoomUsers.create(room_id: room.id, user_id: user_ids[])
    Message.create(content: content, room_id: room.id, user_id: user_id)
  end
end