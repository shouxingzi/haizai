class UserRoom

  include ActiveModel::Model


  def check_user_tweet_rooms(user, tweets)

    rooms = user.rooms.order(tweet_id: "DESC")
    
    destination_rooms = []
    room_ids = RoomUser.where(user_id: user.id).pluck(:room_id)
    room_user = RoomUser.includes(:user).where(room_users: {room_id: room_ids})
    room_user.each do |room|
      hash = {room_id: room.room_id, user_id: room.user.id, user_name: room.user.username}
      destination_rooms << hash
    end
    destination_rooms = destination_rooms.select { |i| i[:user_id] != user.id}


    user_rooms = []
    rooms.each do |room|
      destination_room = destination_rooms.find{|u| u[:room_id] == room.id}
      destination_id = destination_room[:user_id]
      destination_name = destination_room[:user_name]

      temp = Message.group(:user_id, :checked).having("user_id = #{destination_id} and checked = false").count
      if temp.blank?
        checked = true
      else
        checked = false
      end

      hash = {room_id: room.id, room_name: room.room_name, tweet_id: room.tweet_id, current_user_id: user.id, current_user_name: user.username, destination_id: destination_id, destination_name: destination_name, checked: checked}
      user_rooms << hash
    end

    user_tweet_rooms = user_rooms
    return user_tweet_rooms
    # return user_tweet_rooms, no_user_tweet_rooms

  end
end











    # user_tweet_ids = []
    # tweets.each do |tweet|
    #   user_tweet_ids << tweet.id
    # end
    
    # room_tweet_ids = []
    # rooms.each do |room|
    #   room_tweet_ids << room.tweet.id
    # end

    # duplicate_tweet_ids = user_tweet_ids.sort & room_tweet_ids.sort
    # user_tweet_ids = duplicate_tweet_ids
    # user_tweet_rooms = rooms.where(tweet_id: user_tweet_ids).order(tweet_id: "DESC")
    # no_user_tweet_rooms = rooms.where.not(tweet_id: user_tweet_ids).order(tweet_id: "DESC")
    # return user_tweet_rooms, no_user_tweet_rooms

