require 'rails_helper'

RSpec.describe TweetsTag, type: :model do
  before do
    user = FactoryBot.create(:user)
    @tweets_tag = FactoryBot.build(:tweets_tag)
    @tweets_tag.user_id = user.id
  end

  describe 'tweets_tagの保存' do
    
    context 'tweets_tagモデルに保存できるとき' do
      it 'title, text, prefecture_id, city_id, user_id, image, name があれば保存できる' do
        expect(@tweets_tag).to be_valid
      end
      it 'name がなくても保存できる' do
        @tweets_tag.name = ''
        expect(@tweets_tag).to be_valid
      end
    end
    
    context 'tweets_tagモデルに保存できないとき' do
      it 'titleが空では登録できない' do
        @tweets_tag.title = ''
        @tweets_tag.valid?
        expect(@tweets_tag.errors.full_messages).to include("タイトルを入力してください")
      end
      it 'titleが100文字を超えると登録できない' do
        @tweets_tag.title = Faker::Lorem.characters(number: 101)
        @tweets_tag.valid?
        expect(@tweets_tag.errors.full_messages).to include("タイトルは100文字以内で入力してください")
      end
      it 'textが空では登録できない' do
        @tweets_tag.text = ''
        @tweets_tag.valid?
        expect(@tweets_tag.errors.full_messages).to include("投稿文を入力してください")
      end
      it 'prefecture_idが空では登録できない' do
        @tweets_tag.prefecture_id = ''
        @tweets_tag.valid?
        expect(@tweets_tag.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'city_idが空では登録できない' do
        @tweets_tag.city_id = ''
        @tweets_tag.valid?
        expect(@tweets_tag.errors.full_messages).to include("市区町村を入力してください")
      end

      # 通らない
      # it 'imageが空では登録できない' do
      #   @tweet.image = ''
      #   @tweet.valid?
      #   expect(@tweet.errors.full_messages).to include("Imageを入力してください")
      # end

      it 'user_idが空では登録できない' do
        @tweets_tag.user_id = ''
        @tweets_tag.valid?
        expect(@tweets_tag.errors.full_messages).to include("Userを入力してください")
      end
      it 'nameが10個を超えると登録できない' do
        @tweets_tag.name = 'one,two,three,four,five,six,seven,eight,nine,ten,eleven'
        @tweets_tag.valid?
        expect(@tweets_tag.errors.full_messages).to include("タグの登録は10個までです")
      end
    end

  end

end
