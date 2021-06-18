class Destination 
  
  include ActiveModel::Model

  def check_destination(room, current_user_id)
    user_ids =  room.room_users.includes(:user).pluck(:user_id)
    users = User.where(id: user_ids)
    result = users.select {|n| n[:id] != current_user_id}
    destination_user_id = result[0][:id]
    destination = User.find(destination_user_id)
  end
end
