require 'rails_helper'

RSpec.describe "イベント投稿", type: :system do
  before do
    @admin_user = FactoryBot.create(:admin_user)
    @event = FactoryBot.build(:event)
  end

  context 'イベント投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_admin_user_session_path
      fill_in 'email', with: @admin_user.email
      fill_in  'password', with: @admin_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページへ移動する
      visit new_event_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_event_image.jpg')
      attach_file('event[event_image]', image_path, make_visible: true)
      fill_in 'event_name', with: @event.name
      select '2022', from: 'event[event_date(1i)]'
      select '2', from: 'event[event_date(2i)]'
      select '10', from: 'event[event_date(3i)]'
      select '19', from: 'event[event_date(4i)]'
      select '00', from: 'event[event_date(5i)]'
      fill_in 'event_content', with: @event.content
      # 送信するとEventモデルのカウントが１上がることを確認する
      expect {
        find('input[name = "commit"]').click
      }.to change {Event.count}.by(1)
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # ユーザーの詳細ページへ移動する
      visit admin_user_path(@admin_user)
      # ユーザー詳細ページには先ほど投稿した内容の投稿が存在することを確認する（画像）
      expect(page).to have_selector ".show-event-img"
      # ユーザー詳細ページには先ほど投稿した内容のイベント日時が存在することを確認する（イベント名）
      expect(page).to have_content("2022年02月10日 19:00")
      # ユーザー詳細ページには先ほど投稿したイベント名が存在することを確認する (イベント日）
      expect(page).to have_content(@event.name)
    end
  end

  context 'イベント投稿ができないとき' do
    it 'ログインしていないと新規投稿ページへ遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('投稿する')
    end
  end
end

RSpec.describe 'イベント編集', type: :system do
  before do
    @event1 = FactoryBot.create(:event)
    @event2 = FactoryBot.create(:event)
  end
  context 'イベント編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したイベントの編集ができる' do
      # event1を投稿したユーザーでログインする
      visit new_admin_user_session_path
      fill_in 'email', with: @event1.admin_user.email
      fill_in 'password', with: @event1.admin_user.password
      find('input[name="commit"]').click
      # 編集ページへ遷移する
      visit edit_event_path(@event1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#new_image').value
      ).to eq(@event1.event_image)
      expect(
        find('#event_name').value
      ).to eq(@event1.name)
      # 投稿内容を編集する
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      # 編集完了画面に遷移したことを確認する
      # 「更新が完了しました」の文字があることを確認する
      # トップページに遷移する
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
    end
  end
  context 'イベント編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したイベントの編集画面に遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      # ツイート2に「編集」へのリンクがないことを確認する
    end
    it 'ログインしていないとイベントの編集画面に遷移できない' do
      # トップページにいる
      # ツイート1に「編集」へのリンクがないことを確認する
      # ツイート2に「編集」へのリンクがないことを確認する
    end
  end
end
