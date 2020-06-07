require 'rails_helper'

describe MessagesController do
  let(:group) {create(:group)}
  let(:user) {create(:user)}
  
  describe '#index' do

    context 'ログインしている場合' do
      before do
        login user
        get :index, params: {group_id: group.id}
      end
      it '@messageに期待した値が入っていること' do
        expect(assigns(:message)).to be_a_new(Message)
      end
      it '@messageに期待した値が入っていること' do
        expect(assigns(:group)).to eq group
      end
      it 'index.html.hamlに遷移すること' do
        expect(response).to render_template :index
      end
    end

    context 'ログインしていない場合' do
      before do
        get :index, params: {group_id: group.id}
      end
      it 'ログイン画面にリダイレクトすること' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    let(:params){{group_id: group.id, user_id: user.id, message: attributes_for(:message)}}

    context 'ログインしている場合' do
      before do
        login user
      end
      context '保存に成功した場合' do
        subject{
          post :create,
          params: params
        }
        it 'メッセージの保存ができていること' do
          expect{subject}.to change(Message, :count).by(1)
        end
        it 'メッセージ画面に遷移すること' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context '保存に失敗した場合' do
        let(:invalid_params) {{group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil)}}
        subject {
          post:create,
          params: invalid_params
        }
        it 'メッセージの保存ができていないこと' do
          expect{subject}.not_to change(Message, :count)
        end
        it 'index画面に遷移すること' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'ログインしていない場合' do
      it '新規ユーザー画面に遷移すること' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

  # def index
  #   @message = Message.new
  #   @messages = @group.messages.includes(:user)
  # end

  # def create
  #   @message = @group.messages.new(message_params)
  #   if @message.save
  #     redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
  #   else
  #     @messages = @group.messages.includes(:user)
  #     flash.now[:alert] = 'メッセージを入力してください'
  #     render :index
  #   end
  # end