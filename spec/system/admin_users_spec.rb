require 'rails_helper'

RSpec.describe "AdminUsers", type: :system do
  before do
    @admin_user = FactoryBot.build(:admin_user)
    @admin_profile = FactoryBot.create(:admin_profile, admin_user_id: admin_user.id)
  end
  context 'ユーザー新規登録ができる時' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する'
    # トップページに移動する
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    # 新規登録ページへ移動する
    # name, email, passwordを入力する
    # NEXTボタンを押すとユーザー詳細情報入力ページへ移動する
    # ユーザー詳細情報を入力する
    # 会員登録ボタンを押すとAdminUserモデルとAdminProfileのカウントが１上がることを確認する
    # 登録完了ページへ遷移したことを確認する
    # トップへ戻るを押すとトップページへ遷移したことを確認する
    # ログアウトボタンが表示されることを確認する
    # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
  end

  context 'ユーザー新規登録ができない時' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる'
    # トップページに移動する
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    # 新規登録ページへ移動する
    # ユーザー情報を入力する
    # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
    # 新規登録ページへ戻されることを確認する
  end
end
