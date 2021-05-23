class TweetSearch

  include ActiveModel::Model
 
  attr_accessor :prefecture_id, :city_id, :name
 
  def search
    rel = Tweet
 
    rel = rel.where(prefecture_id: prefecture_id) if prefecture_id.present?
    rel = rel.where(city_id: city_id) if city_id.present?

    if name.present?
      tags = name.split(',')
      tag_ids = []
      tags.each do |tag|
        tag_id = Tag.where('name LIKE(?)', "%#{tag}%").pluck(:id)
        tag_id = tag_id[0]
        tag_ids << tag_id      
      end
      tweet_ids = TweetTagRelation.where(tag_id: tag_ids).pluck(:tweet_id)
      rel = rel.where(id: tweet_ids)
    end

    rel
  end
end