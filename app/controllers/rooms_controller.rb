class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @room = Room.new
    @tweet = Tweet.find(params[:tweet_id])
  end


  def create
    room_ids = Room.where(tweet_id: params[:tweet_id]).pluck(:id)
    if room_ids.present?
      room_ids.each do |id|
        room = Room.find_by(id: id)
        room_users = room.users
        room_user_ids = []
        room_users.each do |user|
          room_user_ids << "#{user[:id]}"
        end
        if room_user_ids == params[:user_ids].sort
          redirect_to tweet_room_messages_path(room.tweet_id, room.id) 
        end
      end
    else
      room = Room.new(room_params)
        if room.save
          redirect_to "/tweets/#{room.tweet.id}/rooms/#{room.id}/messages"
        else
          render tenplate: "tweets/show"
        end     
    end
  end


  def destroy
    room = Room.find(params[:id])
    if room.destroy
      redirect_to tweet_path(params[:tweet_id])
    else
      redirect_to tweet_path(params[:tweet_id])
    end
  end

  private
  def room_params
    params.permit(:room_name, :tweet_id, user_ids: [])
  end

end
