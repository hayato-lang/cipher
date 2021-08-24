require 'rails_helper'

RSpec.describe "AdminUsers", type: :system do
  before do
    @admin_user = FactoryBot.build(:admin_user)
    @admin_profile = FactoryBot.build(:admin_profile, admin_user_id: @admin_user.id)
  end
  context 'ユーザー新規登録ができる時' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('Sign')
    # 新規登録ページへ移動する
    visit new_admin_user_registration_path
    # name, email, passwordを入力する
    fill_in 'store_name', with: @admin_user.store_name
    fill_in 'email', with: @admin_user.email
    fill_in 'password', with: @admin_user.password
    fill_in 'password-confirmation', with: @admin_user.password_confirmation
    # NEXTボタンを押すとユーザー詳細情報入力ページへ移動する
    find('input[name="commit"]').click
    # ウィザード形式なので正しいページに遷移しているのか確認
    expect(page).to have_content('郵便番号')
    # ユーザー詳細情報を入力する
    image_path = Rails.root.join('public/images/test_admin_image.jpg')
    attach_file('admin_profile[admin_image]', image_path, make_visible: true)
    fill_in 'postal_code' , with: @admin_profile.postal_code
    select '兵庫県', from: 'admin_profile[prefecture_id]'
    fill_in 'municipality' , with: @admin_profile.municipality
    fill_in 'address' , with: @admin_profile.address
    fill_in 'building-name' , with: @admin_profile.building_name
    fill_in 'phone-number' , with: @admin_profile.phone_number
    fill_in 'profile' , with: @admin_profile.profile
    # 会員登録ボタンを押すとAdminUserモデルとAdminProfileのカウントが１上がることを確認する
    expect{
      find('input[name = "commit"]').click
    }.to change { AdminUser.count }.by(1)
    expect(page).to have_content 'トップへ戻る'
    # トップページへ遷移する
    visit root_path
    # ログアウトボタンが表示されることを確認する
    expect(page).to have_content("Log Out")
    # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('Sign Up')
    expect(page).to have_no_content('Log In')
    end
  end


  context 'ユーザー新規登録ができない時' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
    # トップページに移動する
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    # 新規登録ページへ移動する
    # ユーザー情報を入力する
    # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
    # 新規登録ページへ戻されることを確認する
    end
  end

end
