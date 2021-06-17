class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :tag_list, :prefecture_list, :city_list, :user_list, :search]
  PER = 25

  def index
    @tweets = Tweet.all.order(created_at: "DESC").page(params[:page]).per(PER)
    @search = TweetSearch.new
    @list_title = "最新の投稿一覧"
  end

  def tag_list
    tag = Tag.find(params[:id]).name
    @list_title = "##{tag} の検索結果"
    tweet_ids = TweetTagRelation.where(tag_id: params[:id]).pluck(:tweet_id)
    @tweets = Tweet.where(id: tweet_ids).order(created_at: "DESC").page(params[:page]).per(PER)
    @search = TweetSearch.new
    render :index
  end

  def prefecture_list
    prefecture = Prefecture.find(params[:id]).prefecture
    @list_title = "'#{prefecture}' の検索結果"
    @tweets = Tweet.where(prefecture_id: params[:id]).order(created_at: "DESC").page(params[:page]).per(PER)  
    @search = TweetSearch.new
    render :index
  end

  def city_list
    city = City.find(params[:id]).city
    @list_title = "'#{city}' の検索結果"
    @tweets = Tweet.where(city_id: params[:id]).order(created_at: "DESC").page(params[:page]).per(PER)
    @search = TweetSearch.new
    render :index
  end

  def user_list
    user = User.find(params[:id])
    username = user.username
    @list_title = "'#{username}' の検索結果"
    @tweets = user.tweets.order(created_at: "DESC").page(params[:page]).per(PER)
    render :index
  end
  
  def search
    @search = TweetSearch.new(search_params)
    @tweets = @search.search.order(created_at: "DESC").page(params[:page]).per(PER)
    @list_title = @search.title
    render :index
  end
  

  def new
    @form = TweetsTag.new
  end

  
  def create
    @form = TweetsTag.new(tweet_params)
    if @form.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def ajax_tag_search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end 


  def show
    @tweet = Tweet.find(params[:id])
  end

  def edit
    @tweet = Tweet.find(params[:id])
    @form = TweetsTag.new(tweet: @tweet)
  end


  def update
    @tweet = Tweet.find(params[:id])
    @form = TweetsTag.new(tweet_params, tweet: @tweet)
    if @form.save
      redirect_to tweet_path(@tweet.id)
    else
      render "edit"
    end    
  end


  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def get_cities
    @cities = City.where(prefecture_id: params[:prefecture_id])
    respond_to do |format|
      format.json { render json: @cities }
    end
  end

  
  private
  
  def tweet_params
    params.require(:tweet).permit(:title, :text, :prefecture_id, :city_id, :name, :image).merge(user_id: current_user.id)
  end

  def search_params
    params.require(:tweet_search).permit(:prefecture_id, :city_id, :name)
  end


end
