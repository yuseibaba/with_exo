require 'rails_helper'

RSpec.describe User, type: :model do

  describe '正常系の機能' do
    context 'ユーザーを作成する' do
      it '正しく作成できること' do

      user = FactoryBot.build(:user_tanaka_taro)

      expect(user).to be_valid
      user.save

      created_user = User.find(1)
      expect(created_user.name).to eq('田中 太郎')
      expect(created_user.email).to eq('taro.tanaka@example.jp')
      expect(created_user.password_digest).to eq('password')
      expect(created_user.introduce_comment).to eq('はじめまして。田中 太郎と申します。')
      end
    end
  end

  describe 'ユーザー登録時の入力項目について' do
    context '必須入力であること' do
      
      let(:new_user) { User.new }

      it '名前が必須であること' do
        expect(new_user).not_to be_valid
        expect(new_user.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end

      it 'メールアドレスが必須であること' do
        expect(new_user).not_to be_valid
        expect(new_user.errors[:email]).to include(I18n.t('errors.messages.blank'))
      end

      it 'パスワードが必須であること' do
        expect(new_user).not_to be_valid
        expect(new_user.errors[:password]).to include(I18n.t('errors.messages.blank'))
      end

      it '登録できないこと' do
        expect(new_user.save).to be_falsey
      end

    end
  end

  describe 'ユーザー登録時の入力項目の文字数制限について' do

    user = FactoryBot.build(:user_a)

    context '名前の文字数が55文字を超過する場合' do
      it 'エラーになること' do
        expect(user).not_to be_valid
        expect(user.errors[:name]).to include('は50文字以内で入力してください')
      end
    end

    context 'メールアドレスの文字数が255字を超過する場合' do
      it 'エラーになること' do
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include('は255文字以内で入力してください')
      end
    end

    context 'パスワードの文字数が72文字を超過する場合' do
      it 'エラーになること' do
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include('は72文字以内で入力してください')
      end
    end

    context '自己紹介文の文字数が255字を超過する場合' do
      it 'エラーになること' do
        expect(user).not_to be_valid
        expect(user.errors[:introduce_comment]).to include('は255文字以内で入力してください')
      end
    end
    
  end

  describe 'パスワードとパスワード（確認用）の値の一致' do
    context 'パスワードとパスワード（確認用）の値が一致しない場合' do
      it 'エラーになること' do
        new_user = User.new(
          password:'pass',
          password_confirmation:'pa')
          expect(new_user).not_to be_valid
          expect(new_user.errors[:password_confirmation]).to include(I18n.t('errors.messages.confirmation'))
      end
    end
  end

  describe 'ユーザー登録時の条件' do
    context 'すでに登録されているメールアドレスで登録する' do
      it 'エラーになること' do
        new_user1 = FactoryBot.build(:user_tanaka_taro)
        new_user1.save

        new_user2 = FactoryBot.build(:user_tanaka_taro)

        expect(new_user2).not_to be_valid
        expect(new_user2.errors[:email]).to include(I18n.t('errors.messages.taken'))
        expect(new_user2.save).to be_falsey
        expect(User.all.size).to eq 1
      end
    end
  end

  describe 'メールアドレスの形式' do
    context '不正な形式のメールアドレスの場合' do
      it 'エラーになること' do
        new_user=User.new
        new_user.email = 'a@a'
        expect(new_user).not_to be_valid
        expect(new_user.errors[:email]).to include(I18n.t('errors.messages.invalid'))
      end
    end
  end

end
