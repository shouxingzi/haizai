require 'rails_helper'

RSpec.describe RoomMessage, type: :model do
  before do 
    @room_message = FactoryBot.build(:room_message)
  end

  describe 'room_messageの保存' do

    context 'room_messageモデルに保存できるとき' do
      it 'room_name, tweet_id, content, current_user_id, tweet_user_id があれば保存できる' do
        expect(@room_message).to be_valid
      end
    end

    context 'room_messageモデルに保存できないとき' do
      it 'contentが空だと保存できない' do
        @room_message.content = ''
        @room_message.valid?
        expect(@room_message.errors.full_messages).to include("Contentを入力してください")
      end
      it 'current_user_idが空だと保存できない' do
        @room_message.current_user_id = ''
        @room_message.valid?
        expect(@room_message.errors.full_messages).to include("Current userを入力してください")
      end
      it 'tweet_user_idが空だと保存できない' do
        @room_message.tweet_user_id = ''
        @room_message.valid?
        expect(@room_message.errors.full_messages).to include("Tweet userを入力してください")
      end
      it 'tweet_idが空だと保存できない' do
        @room_message.tweet_id = ''
        @room_message.valid?
        expect(@room_message.errors.full_messages).to include("Tweetを入力してください")
      end
      it 'room_nameが空だと保存できない' do
        @room_message.room_name = ''
        @room_message.valid?
        expect(@room_message.errors.full_messages).to include("Room nameを入力してください")
      end
    end

  end
  
end
