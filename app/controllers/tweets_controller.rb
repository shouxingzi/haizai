class TweetsController < ApplicationController
  
  def index
    @tweets = Tweet.all
    @search = TweetSearch.new
  end

  def tag_list
    tweet_ids = TweetTagRelation.where(tag_id: params[:id]).pluck(:tweet_id)
    @tweets = Tweet.where(id: tweet_ids)
    render :index
  end

  def tag_search
    redirect_to root_path if params[:keyword] == ""
    tag_ids = Tag.where('name LIKE(?)', "%#{params[:keyword]}%").pluck(:id)
    tweet_ids = TweetTagRelation.where(tag_id: tag_ids)
    @tweets = Tweet.where(id: tweet_ids)

    render :index
  end

  def search
    @search = TweetSearch.new(search_params)
    @tweets = @search.search
    render :index
  end
  

  def new
    @form = TweetsTag.new
  end

  def create
    @form = TweetsTag.new(tweet_params)
    if @form.valid?
      tag_list = @form.name.split(',')
      @form.save(tag_list)
      return redirect_to root_path
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
    if @form.valid?
      tag_list = params[:tweet][:name].split(",")
      @form.save(tag_list)
      return redirect_to root_path
    else
      render "edit"
    end    
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to root_path
  end


  def get_cities
    @cities = City.where(prefecture_id: params[:prefecture_id])
    respond_to do |format|
      format.json { render json: @cities }
    end
  end

  
  private
  
  def tweet_params
    params.require(:tweet).permit(:title, :text, :prefecture_id, :city_id, :image, :name).merge(user_id: current_user.id)
  end

  def search_params
    params.require(:tweet_search).permit(:prefecture_id, :city_id, :name)
  end

end
