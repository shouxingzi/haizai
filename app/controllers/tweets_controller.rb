class TweetsController < ApplicationController

  def index
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private
  
  def tweet_params
    params.require(:tweet).permit(:title, :text, :prefecture_id, :city_id, :image).merge(user_id: current_user.id)
  end

end
