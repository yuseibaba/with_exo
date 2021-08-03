require 'rails_helper'

RSpec.describe User, type: :model do

  describe '正常系の機能' do
    context 'ユーザーを作成する' do
      it '正しく作成できること' do
        user = User.new(
          id: 1,
          name: '田中 太郎',
          email: 'taro.tanaka@example.jp',
          password_digest: 'password',
          introduce_comment: 'はじめまして。田中 太郎と申します。'
        )

      expect(user).to be_valid
      user.save

      created_user = User.find(1)
      expect(created_user.name).to eq('田中 太郎')
      expect(created_user.email).to eq('taro.tanaka@example.jp')
      expect(created_user.introduce_comment).to eq('はじめまして。田中 太郎と申します。')
      end
    end
  end

  describe '入力項目の有無' do
    context '必須入力であること' do
      it '名前が必須であること' do
        new_user = User.new
        expect(new_user).not_to be_valid
        expect(new_user.errors[:name]).to include('Can not be blank')
      end

      it 'メールアドレスが必須であること' do
        new_user = User.new
        expect(new_user).not_to be_valid
        expect(new_user.errors[:mail]).to include('Can not be blank')
      end

      it '登録できないこと' do
        new_user = User.new
        expect(new_user.save).to be_falsey
      end

    end
  end

end
