class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :tag_list, :prefecture_list, :city_list, :user_list, :search]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  PER = 25

  def index
    @tweets = Tweet.includes(:user, :prefecture, :city).order(created_at: "DESC").page(params[:page]).per(PER)
    @search = TweetSearch.new
    @list_title = "最新の投稿一覧"
  end

  # タグに紐づく記事一覧を抽出する
  def tag_list
    tag = Tag.find(params[:id]).name
    @list_title = "##{tag} の検索結果"
    tweet_ids = TweetTagRelation.where(tag_id: params[:id]).pluck(:tweet_id)
    @tweets = Tweet.where(id: tweet_ids).order(created_at: "DESC").page(params[:page]).per(PER)
    @search = TweetSearch.new
    render :index
  end

  # 提供場所（都道府県）に紐づく記事一覧を抽出する
  def prefecture_list
    prefecture = Prefecture.find(params[:id]).prefecture
    @list_title = "'#{prefecture}' の検索結果"
    @tweets = Tweet.where(prefecture_id: params[:id]).order(created_at: "DESC").page(params[:page]).per(PER)  
    @search = TweetSearch.new
    render :index
  end

  # 提供場所（市区町村）に紐づく記事一覧を抽出する
  def city_list
    city = City.find(params[:id]).city
    @list_title = "'#{city}' の検索結果"
    @tweets = Tweet.where(city_id: params[:id]).order(created_at: "DESC").page(params[:page]).per(PER)
    @search = TweetSearch.new
    render :index
  end

  # ユーザーに紐づく記事一覧を抽出する
  def user_list
    user = User.find(params[:id])
    username = user.username
    @list_title = "'#{username}' の検索結果"
    @tweets = user.tweets.order(created_at: "DESC").page(params[:page]).per(PER)
    render :index
  end
  
  # 記事検索
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

  # タグ、サジェスト機能のための非同期通信
  def ajax_tag_search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end 


  def show
  end


  def edit
    @form = TweetsTag.new(tweet: @tweet)
  end


  def update
    @form = TweetsTag.new(tweet_params, tweet: @tweet)
    if @form.save
      redirect_to tweet_path(@tweet.id)
    else
      render "edit"
    end    
  end


  def destroy
    if @tweet.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  # 提供場所（都道府県）の選択によって提供場所（市区町村）のプルダウンメニューの内容をかえる
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


  def move_to_index
    if current_user.id != @tweet.user_id
      redirect_to root_path
    end
  end


  def set_tweet
    @tweet = Tweet.find(params[:id])
  end


end
