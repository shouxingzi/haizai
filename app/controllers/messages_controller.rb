class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    user_ids = RoomUser.where(room_id: params[:room_id]).pluck(:user_id)
    if user_ids.include?(current_user.id)
      @message = Message.new
      @room = Room.find(params[:room_id])
      @tweet = Tweet.find(params[:tweet_id])

      @messages = @room.messages.includes(:user).order(created_at: "ASC")
      
      # 相手からの新着メッセージがある場合は既読にする
      destination_messages = @messages.where.not(user_id: current_user.id)
      if destination_messages.present?
        destination_messages.update(checked: true)
      end

      # 相手情報の取得
      destination = Destination.new
      @destination = destination.check_destination(@room, current_user.id)
    else
      redirect_to root_path
    end
  end  
  

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to "/tweets/#{@room.tweet.id}/rooms/#{@room.id}/messages"
    else
      @messages = @room.messages.includes(:user)
      @tweet = Tweet.find(params[:tweet_id])
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
  
end
