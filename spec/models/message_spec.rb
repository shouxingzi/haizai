require 'rails_helper'

RSpec.describe Message, type: :model do
  before do 
    @message = FactoryBot.build(:message)
  end

  describe 'messageモデルの保存' do

    context 'messageモデルに保存できるとき' do
      it 'content があれば保存できる' do
        expect(@message).to be_valid
      end
    end

    context 'messageモデルに保存できないとき' do
      it 'contentが空だと保存できない' do
        @message.content = ''
        @message.valid?
        expect(@message.errors.full_messages).to include("Contentを入力してください")
      end
    end

  end
  
end

