require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    context 'messageを保存できる場合' do
      it 'contentがある場合保存できること' do
        expect(build(:message, image: nil)).to be_valid
      end

      it 'imageがある場合保存できること' do
        expect(build(:message, content: nil)).to be_valid
      end

      it 'contentとimageがある場合保存できること' do
        expect(build(:message)).to be_valid
      end
    end

    context 'messageを保存できない場合' do
      it ' contentとimageが両方ない場合保存できないこと' do
        message = build(:message, content: nil, image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください")
      end

      it 'group_idがない場合保存できないこと' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      it ' user_idがない場合保存できないこと' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end