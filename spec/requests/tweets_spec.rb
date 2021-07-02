require 'rails_helper'

def get_root_path
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  get root_path, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
end

describe "TweetsController", type: :request do
  before do
    @tweet = FactoryBot.create(:tweet)
    @tag = FactoryBot.create(:tag)
    tweet_tag_relation.FactoryBot.build(:tweet_tag_relations)
    # tweet_tag_relation.tweet_id = @tweet.id
    # tweet_tag_relation.tag_id = @tag.id
    # tweet_tag_relation.FactoryBot.create(:tweet_tag_relations)
  end

  describe "GET /tweets" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get_root_path
      binding.pry
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのタイトルが存在する' do
      get_root_path
      expect(response.body).to include(@tweet.title)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの引き渡し場所（都道府県）が存在する' do
      get_root_path
      expect(response.body).to include(@tweet.prefecture.prefecture)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの引き渡し場所（市区町村)が存在する' do
      get_root_path
      expect(response.body).to include(@tweet.city.city)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像が存在する' do
      get_root_path
      expect(response.body).to include(@tweet.image.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの投稿者名が存在する' do
      get_root_path
      expect(response.body).to include(@tweet.user.username)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの投稿日が存在する' do
      get_root_path
      expect(response.body).to include(@tweet.created_at.strftime('%Y/%m/%d'))
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのタグが存在する' do
      get_root_path
      binding.pry
      expect(response.body).to include(@tag.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      get_root_path
      expect(response.body).to include('投稿を検索')
    end


  end
end
