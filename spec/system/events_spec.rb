require 'rails_helper'

RSpec.describe 'イベント投稿', type: :system do
  before do
    @admin_user = FactoryBot.create(:admin_user)
    @event = FactoryBot.build(:event)
  end

  context 'イベント投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_admin_user_session_path
      fill_in 'email', with: @admin_user.email
      fill_in 'password', with: @admin_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページへ移動する
      visit new_event_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_event_image.jpeg')
      attach_file('event[event_image]', image_path, make_visible: true)
      fill_in 'event_name', with: @event.name
      select '2022', from: 'event[event_date(1i)]'
      select '2', from: 'event[event_date(2i)]'
      select '10', from: 'event[event_date(3i)]'
      select '19', from: 'event[event_date(4i)]'
      select '00', from: 'event[event_date(5i)]'
      fill_in 'event_content', with: @event.content
      # 送信するとEventモデルのカウントが１上がることを確認する
      expect do
        find('input[name = "commit"]').click
      end.to change { Event.count }.by(1)
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # ユーザーの詳細ページへ移動する
      visit admin_user_path(@admin_user)
      # ユーザー詳細ページには先ほど投稿した内容の投稿が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test_event_image.jpeg']")
      # ユーザー詳細ページには先ほど投稿した内容のイベント日時が存在することを確認する（イベント名）
      expect(page).to have_content('2022年02月10日 19:00')
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
      expect(page).to have_selector("img[src$='test_event_image.jpeg']")
      expect(
        find('#event_name').value
      ).to eq(@event1.name)
      expect(
        find('#event_event_date_1i').value
      ).to eq('2021')
      expect(
        find('#event_event_date_2i').value
      ).to eq('10')
      expect(
        find('#event_event_date_3i').value
      ).to eq('9')
      expect(
        find('#event_event_date_4i').value
      ).to eq('21')
      expect(
        find('#event_event_date_5i').value
      ).to eq('00')
      expect(
        find('#event_content').value
      ).to eq(@event1.content)
      # 投稿内容を編集する
      image_path = Rails.root.join('public/images/test2_event_image.jpg')
      attach_file('event[event_image]', image_path, make_visible: true)
      fill_in 'event_name', with: "#{@event1.name}+編集したテキスト"
      select '2023', from: 'event[event_date(1i)]'
      select '3', from: 'event[event_date(2i)]'
      select '4', from: 'event[event_date(3i)]'
      select '20', from: 'event[event_date(4i)]'
      select '30', from: 'event[event_date(5i)]'
      fill_in 'event_content', with: "#{@event1.content}+編集したテキスト"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Event.count }.by(0)
      # イベント詳細ページに遷移したことを確認する
      expect(current_path).to eq(event_path(@event1))
      # イベント詳細ページには先ほど変更したイベント内容が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test2_event_image.jpg']")
      # イベント詳細ページには先ほど変更したイベント内容が存在することを確認する（イベント名）
      expect(page).to have_content("#{@event1.name}+編集したテキスト")
      # イベント詳細ページには先ほど変更したイベント内容が存在することを確認する (日時）
      expect(page).to have_content('2023年03月04日 20:30')
      # イベント詳細ページには先ほど変更したイベント内容が存在することを確認する（イベント概要）
      expect(page).to have_content("#{@event1.content}+編集したテキスト")
    end
  end
  context 'イベント編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したイベントの編集画面に遷移できない' do
      # event1を投稿したユーザーでログインする
      visit new_admin_user_session_path
      fill_in 'email', with: @event1.admin_user.email
      fill_in 'password', with: @event1.admin_user.password
      find('input[name="commit"]').click
      # event2の編集ページへ遷移する
      visit edit_event_path(@event2)
      # event2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link 'イベントの編集', href: edit_event_path(@event2)
    end
    it 'ログインしていないとイベントの編集画面に遷移できない' do
      # event1の詳細ページへ遷移する
      visit edit_event_path(@event1)
      # event1に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link 'イベントの編集', href: edit_event_path(@event1)
      # event2の編集ページへ遷移する
      visit edit_event_path(@event2)
      # event2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link 'イベントの編集', href: edit_event_path(@event2)
    end
  end
end

RSpec.describe 'イベント削除', type: :system do
  before do
    @event1 = FactoryBot.create(:event)
    @event2 = FactoryBot.create(:event)
  end
  context 'イベント削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したイベントの削除ができる' do
      # event1を投稿したユーザーでログインする
      visit new_admin_user_session_path
      fill_in 'email', with: @event1.admin_user.email
      fill_in 'password', with: @event1.admin_user.password
      find('input[name="commit"]').click
      # イベント詳細ページへ遷移する
      visit event_path(@event1)
      # event1に「削除」へのリンクがあることを確認する
      expect(page).to have_link '削除', href: event_path(@event1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect do
        find_link('削除', href: event_path(@event1)).click
      end.to change { Event.count }.by(-1)
      # ユーザー詳細ページへ遷移する
      visit admin_user_path(@event1.admin_user_id)
      # ユーザー詳細ページにはevent1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector("img[src$='test_event_image.jpeg']")
      # ユーザー詳細ページにはevent1の内容が存在しないことを確認する（日時）
      expect(page).to have_no_content('#2021-10-09 21:00:00')
      # ユーザー詳細ページにはevent1の内容が存在しないことを確認する（イベント名）
      expect(page).to have_no_content(@event1.name.to_s)
    end
  end
  context 'イベント削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したイベントの削除ができない' do
      # event1を投稿したユーザーでログインする
      visit new_admin_user_session_path
      fill_in 'email', with: @event1.admin_user.email
      fill_in 'password', with: @event1.admin_user.password
      find('input[name="commit"]').click
      # イベント詳細ページへ遷移する
      visit event_path(@event2)
      # event2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: edit_event_path(@event2)
    end
    it 'ログインしていないとイベントの削除ボタンがない' do
      # event1のイベント詳細ページへ遷移する
      visit event_path(@event1)
      # ツイート1に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: edit_event_path(@event1)
      # event2のイベント詳細ページへ遷移する
      visit event_path(@event2)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: edit_event_path(@event2)
    end
  end
end
