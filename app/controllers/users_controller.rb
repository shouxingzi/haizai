class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show


  def show
    user = User.find(params[:id])
    @tweets = user.tweets.order(created_at: "DESC")

    user_rooms = UserRoom.new
    @user_tweet_rooms = user_rooms.check_user_tweet_rooms(user, @tweets)

    # @user_tweet_rooms, @no_user_tweet_rooms  = user_rooms.check_user_tweet_rooms(user, @tweets)

  end


  def user_tweet_list
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end


end
