class TweetSearch

  include ActiveModel::Model
 
  attr_accessor :prefecture_id, :city_id, :name
 

  def search
    rel = Tweet
 
    rel = rel.where(prefecture_id: prefecture_id) if prefecture_id.present?
    rel = rel.where(city_id: city_id) if city_id.present?

    if name.present?
      tags = name.split(/[[:blank:]]+/)
      tag_ids = []
      tags.each do |tag|
        tag_id = Tag.where('name LIKE(?)', "%#{tag}%").pluck(:id)
        tag_id = tag_id[0]
        tag_ids << tag_id      
      end
      relation_arry = TweetTagRelation.where(tag_id: tag_ids)
      tweet_ids = relation_arry.group(:tweet_id).having("count(tweet_id) = #{tags.length}").pluck(:tweet_id)
      rel = rel.where(id: tweet_ids)
    end
    rel
  end


  def title
    title = []
    if prefecture_id.present?
      prefecture = Prefecture.find(prefecture_id).prefecture
      title << prefecture
    end

    if city_id.present?
      city = City.find(city_id).city
      title << city
    end

    if name.present?
      title << name
    end

    title = "#{title}の検索結果"
  end
end