class UserRoom

  include ActiveModel::Model

  def check_user_tweet_rooms(user, tweets)
    # ユーザーが持つroom全てを取得
    rooms = user.rooms.order(tweet_id: "DESC")

    # 送信先の配列を作る
    destination_rooms = []
    # ログインユーザーが持つルームid全てを取得
    room_ids = RoomUser.where(user_id: user.id).pluck(:room_id)
    # RoomUserのroom_id = ログインユーザーが持つroom_idになっているデータを全て取得
    room_user = RoomUser.includes(:user).where(room_users: {room_id: room_ids})
    # 独自の配列に生計
    room_user.each do |room|
      hash = {room_id: room.room_id, user_id: room.user.id, user_name: room.user.username}
      destination_rooms << hash
    end
    # user_idが相手のidになているroom情報だけ抽出
    destination_rooms = destination_rooms.select { |i| i[:user_id] != user.id}


    user_rooms = []
    rooms.each do |room|
      destination_room = destination_rooms.find{|u| u[:room_id] == room.id}
      destination_id = destination_room[:user_id]
      destination_name = destination_room[:user_name]
      
      messages = Message.where(room_id: room.id)
      temp = messages.group(:user_id, :checked).having("user_id = #{destination_id} and checked = false").count

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

  end
end











