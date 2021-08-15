RSpec.describe "User", type: :system do

  describe '正常' do
    context "ユーザーを作成する" do
      it "正しく作成できること" do
  
        user = FactoryBot.create(:user_tanaka_taro)
        
        visit "/signup"
        fill_in '名前', with: user.name
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード（確認用）', with: user.password_comfirmation
        sleep 2
        
        click_button '新規登録'

        expect(page).to have_content '登録が完了しました'
        expect(page).to have_content '名前: 田中 太郎'
        expect(page).to have_content 'メールアドレス: taro.tanaka@example.com'
        expect(page).to have_content 'パスワード: password'
        sleep 5
      end
    end
  end
end