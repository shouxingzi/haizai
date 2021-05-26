class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    user_ids =  @room.room_users.includes(:user).pluck(:user_id)
    users = User.where(id: user_ids)
    destination = users.select {|n| n[:id] != current_user.id}
    @destination = destination[0][:username]
    @tweet = Tweet.find(params[:tweet_id])
    @messages = @room.messages.includes(:user)
  end  

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to "/tweets/#{@room.tweet.id}/rooms/#{@room.id}/messages"
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
