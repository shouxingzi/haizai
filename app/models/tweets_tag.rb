
class TweetsTag

  include ActiveModel::Model
  attr_accessor :title, :text, :prefecture_id, :city_id, :user_id, :image, :name

  with_options presence: true do
    validates :title
    validates :text
    validates :prefecture_id
    validates :city_id
    validates :user_id
    validates :image
  end
  validates :title,length: { maximum: 100 }
  validate :name_valid

   # tweetがすでに保存されているものか、新規のものかで、PUTとPATCHを分ける
   delegate :persisted?, to: :tweet

  def initialize(attributes = nil, tweet: Tweet.new)
    @tweet = tweet
    attributes ||= default_attributes
    super(attributes)
  end


  def save
    return if invalid?
    ActiveRecord::Base.transaction do
      @tweet.update(title: title, text: text, prefecture_id: prefecture_id, city_id: city_id, user_id: user_id, image: image)
      # @tweetに紐付くタグがあれば、tweet_tag_relationsテーブルの紐付くレコードを全て消去する
      @tweet.tweet_tag_relations.each do |tag|
        tag.delete
      end
      # tag_listのタグの数だけ、tagsテーブルと、car_tag_relationsテーブルに保存する
      tags = name.split(",")
      tags.each do |tag_name|
        tag = Tag.where(name: tag_name).first_or_initialize
        tag.save
        tweet_tag = TweetTagRelation.where(tweet_id: @tweet.id, tag_id: tag.id).first_or_initialize
        tweet_tag.update(tweet_id: @tweet.id, tag_id: tag.id)
      end
    end
  end


  def to_model
    tweet
  end

  private

  attr_reader :tweet

  def default_attributes
    {
      title: tweet.title,
      text: tweet.text,
      prefecture_id: tweet.prefecture_id,
      city_id: tweet.city_id,
      user_id: tweet.user_id,
      image: tweet.image,
      name: tweet.tags.pluck(:name).join(',')
    }
  end

  def name_valid
    tags = name.split(",")
    if tags.length > 10
      errors.add(:name, "タグの登録は10個までです")
    end
  end
  
end