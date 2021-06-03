class Destination 
  
  include ActiveModel::Model

  def check_destination(room, current_user_id)
    user_ids =  room.room_users.includes(:user).pluck(:user_id)
    users = User.where(id: user_ids)
    destination = users.select {|n| n[:id] != current_user_id}
    destination = destination[0][:username]
  end
end
