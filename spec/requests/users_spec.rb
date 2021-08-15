require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe '正常' do
    context "ユーザーの新規登録" do
      it "登録できること" do
      
        get "/signup"
        # [Point.3-15-2]正常に応答することを確認します。
        expect(response).to have_http_status(200)
  
        # [Point.3-15-3]正常な入力値を送信します。
        post "/users", params: { user: FactoryBot.attributes_for(:user_tanaka_taro) }
        # [Point.3-15-4]リダイレクト先に移動します。
        redirect_to @user
        # [Point.3-15-5]送信完了のメッセージが含まれることを検証します。
        "<html><body>You are being <a href=\"http://www.example.com/users/4\">redirected</a>.</body></html>".to include "登録が完了しました"
      end
    end
  end

end
