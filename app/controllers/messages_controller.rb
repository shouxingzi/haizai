class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @tweet = Tweet.find(params[:tweet_id])

    @messages = @room.messages.includes(:user).order(created_at: "ASC")

    destination_messages = @messages.where.not(user_id: current_user.id)
    if destination_messages.present?
      destination_messages.update(checked: true)
    end

    destination = Destination.new
    @destination = destination.check_destination(@room, current_user.id)

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
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
