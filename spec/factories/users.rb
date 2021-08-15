FactoryBot.define do
  factory :user_tanaka_taro, class: 'User' do
    id { 1 }
    name { '田中 太郎'}
    email { 'taro.tanaka@example.jp' }
    password { 'password' }
    password_confirmation { 'password' }
    password_digest { 'password' }
    introduce_comment { 'はじめまして。田中 太郎と申します。' }
  end

  factory :user_a, class: 'User' do 
    id { 2 }
    name { 'a' * 51 }#51文字
    email{ 'a' * 256 }#256文字
    password { 'a' * 73 }#73文字
    introduce_comment { 'a' * 256 }#256文字
  end
end
