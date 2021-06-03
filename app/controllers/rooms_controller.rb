class RoomsController < ApplicationController
  before_action :authenticate_user!


  def new
    room_ids = Room.where(tweet_id: params[:tweet_id]).pluck(:id)
    if room_ids.present?
      room_ids.each do |id|
        room = Room.find_by(id: id)
        room_users = room.users
        room_user_ids = []
        room_users.each do |user|
          room_user_ids << user[:id]
        end
        current_user_ids = [current_user.id, Tweet.find(params[:tweet_id]).user_id]
        if room_user_ids.sort == current_user_ids.sort
          redirect_to tweet_room_messages_path(room.tweet_id, room.id) 
        end
      end
    end
    @message_form = RoomMessage.new
    @tweet = Tweet.find(params[:tweet_id])
  end



  def create
    @message_form = RoomMessage.new(message_form_params)
    if room = @message_form.save
      redirect_to tweet_room_messages_path(params[:tweet_id], room.room_id)
    else
      render :new
    end
  end


  def destroy
    room = Room.find(params[:id])
    if room.destroy
      redirect_to "/users/#{current_user.id}"
    end
  end


  private
  def message_form_params
    params.require(:room_message).permit(:content, :room_name, :tweet_id, :tweet_user_id, :current_user_id)
  end

end
