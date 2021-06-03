class RoomMessage

  include ActiveModel::Model
  attr_accessor :room_name, :tweet_id, :content, :current_user_id, :tweet_user_id, :checked

  with_options presence: true do
    validates :room_name
    validates :tweet_id
    validates :content
    validates :current_user_id
    validates :tweet_user_id
  end


  def save
    room = Room.create(room_name: room_name, tweet_id: tweet_id)
    RoomUser.create(room_id: room.id, user_id: tweet_user_id)
    RoomUser.create(room_id: room.id, user_id: current_user_id)
    Message.create(content: content, room_id: room.id, user_id: current_user_id)
  end

  
end


