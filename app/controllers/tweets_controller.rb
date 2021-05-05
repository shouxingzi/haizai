class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all
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

  def show
    @tweet = Tweet.find(params[:id])
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to action: :show
    else
      render action: :edit
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to root_path
  end

  # def cities_select
  #   cities = City.where(prefecture_id: params[:tweet][:prefecture_id])
  #   render json: { post: cities }
  # end

  private
  
  def tweet_params
    params.require(:tweet).permit(:title, :text, :prefecture_id, :city_id, :image).merge(user_id: current_user.id)
  end

end
