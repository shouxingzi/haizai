class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show


  def show
    user = User.find(params[:id])
    @tweets = user.tweets
    @rooms = user.rooms
  end

  def user_tweet_list
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end


end
