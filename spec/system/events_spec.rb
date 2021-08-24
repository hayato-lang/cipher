require 'rails_helper'

RSpec.describe "Events", type: :system do
  before do
    @admin_user = FactoryBot.create(:admin_user)
    @event = FactoryBot.build(:event)
  end

  context 'イベント投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      # 新規投稿ページへのボタンがあることを確認する
      # 投稿ページへ移動する
      # フォームに情報を入力する
      # 送信するとEventモデルのカウントが１上がることを確認する
      # トップページへ遷移する
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
    end
  end

  context 'イベント投稿ができないとき' do
    it 'ログインしていないと新規投稿ページへ遷移できない' do
      # トップページに遷移する
      # 新規投稿ページへのボタンがないことを確認する
    end
  end
end
