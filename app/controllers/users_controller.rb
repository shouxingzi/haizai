class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show

  def show
    if current_user.id == params[:id].to_i
      user = User.find(params[:id])
      @tweets = user.tweets.order(created_at: "DESC") #ユーザーが投稿した記事一覧の抽出
      user_rooms = UserRoom.new
      @user_tweet_rooms = user_rooms.check_user_tweet_rooms(user, @tweets) #ユーザーが参加しているチャットルーム一覧の抽出
    else
      redirect_to root_path
    end
  end

end


