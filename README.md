# Cipher
全国のライブハウスのイベント情報を閲覧することのできるアプリです。
音楽が楽しい時にはより楽しい気持ちになり、
悲しい時や落ち込んだ時には励まされました。

[![Image from Gyazo](https://i.gyazo.com/016effc214dda5658a386bc557a4f581.gif)](https://gyazo.com/016effc214dda5658a386bc557a4f581)

[![Image from Gyazo](https://i.gyazo.com/0182eb4436a0fd61a62372abcef2a2d9.gif)](https://gyazo.com/0182eb4436a0fd61a62372abcef2a2d9)

# 制作背景
テックキャンプを通じて学習したRuby on Railsを利用したWebアプリケーション作成の理解を深める為、オリジナルでWebアプリケーションを作成してみました。
私が音楽好きであること、昨今のコロナ禍において、ライブハウスが軒並み閉店してしまっている情勢の中、こんなWebアプリケーションがあればライブハウス管理者の手助けになるのでは？と思い作成してみようと思いました。Webアプリケーションに訪れたユーザーが長く滞在してもらえるようにJqueryを用いたスライドショーやActiveStorage等を利用してオシャレなページを心掛けました。

# アプリケーションの目的
個々のライブハウスの情報を露出する場を提供、ライブ情報を通してアーティストの認知度を高める。
集客を増やしたいライブハウス管理者、ライブ好きなユーザー、出張先などでどんなライブイベントがあるのか探しているユーザー等をターゲットに開発した。
ライブハウス管理者が新規登録後にできる機能
- イベント投稿
- イベント編集

ユーザーが新規登録後にできる機能
- いいね機能
- コメント機能（未実装）

誰でも利用できる機能
- イベント検索
- イベント閲覧
- ライブハウス情報閲覧

# 使用技術
- Ruby 2.6.5
- Ruby on Rails 6.0.4
- MySQL 5.6.51
- Nginx
- AWS
  - EC2
  - S3
- Capistrano3
- RSpec

# 機能一覧
- ユーザー登録機能(devise)
  - ユーザー登録機能(管理者)
    - ユーザー詳細登録機能(ウィザード形式を採用)
  - ユーザー登録機能
- 投稿機能
  - イベント投稿(ActiveStorageを利用し画像を含めて投稿)
- いいね機能（非同期通信）

# テスト

- RSpec
  - 単体テスト(model)
  - 結合テスト(model)

# 実装した主な機能

## ユーザー新規登録(管理者)

[![Image from Gyazo](https://i.gyazo.com/ddb125d70d636bd24f60aa2f9070bbc6.png)](https://gyazo.com/ddb125d70d636bd24f60aa2f9070bbc6)

ウィザード形式で実装

[![Image from Gyazo](https://i.gyazo.com/396efdf677eb38e56c531eff9620e359.gif)](https://gyazo.com/396efdf677eb38e56c531eff9620e359)

## ユーザー新規登録（管理者）が完了するとトップページの下部のライブハウス一覧表示のスライドショーに表示される

[![Image from Gyazo](https://i.gyazo.com/85b768a97a147453b4f63570e6daf7f8.gif)](https://gyazo.com/85b768a97a147453b4f63570e6daf7f8)

## ユーザー新規登録（管理者）が完了したユーザーはイベントを投稿することができる

[![Image from Gyazo](https://i.gyazo.com/52fa9f8b868091fb39ac6518d7843a2b.gif)](https://gyazo.com/52fa9f8b868091fb39ac6518d7843a2b)



<!-- 実装した機能を複数掲載 -->


# 今後実装したい機能

| 機能                     | 目的                                                                | 詳細                                                                                                                 | 
| ------------------------ | ------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | 
| コメント機能             | ユーザーと管理者がコミュニケーションを取れるようにするため。        | 新規登録したユーザーと管理者はイベント詳細ページの下部でコメント機能を使用してコミュニケーションを取ることができる。 | 
| 都道府県別一覧表示機能   | ライブハウスの情報を探しやすくするため。                            | jqueryで実装されたJmapを利用して、各都道府県ごとに一覧表示機能を実装。                                               | 
| ユーザー編集機能(管理者) | ライブハウス情報が変更時に編集できるようにするため                  | deviseでユーザー新規登録機能を実装した時のように登録された情報を編集機能を使って編集できるようにする。               | 
| レスポンシブデザイン     | メディアクエリを利用し画面のサイズに応じてcssを変化させる。         | メディアクエリを利用することでPC、タブレット、スマホで画面表示を切り替える。                                         | 

# テーブル設計

## admin_usersテーブル

| Column             | Types   | Options                    | 
| ------------------ | ------- | ---------------------------| 
| store_name         | string  |  null: false               | 
| email              | string  |  null: false, unique: true | 
| encrypted_password | string  |  null: false               | 

### Association
- has_many :events
- has_many :comments
- has_many :likes
- has_one :admin_profile


## admin_profilesテーブル

| Column             | Types      | Options                        | 
| ------------------ | -------    | -------------------------------| 
| postal_code        | string     | null: false                    | 
| prefecture_id      | integer    | null: false                    | 
| municipality       | string     | null: false                    | 
| address            | string     | null: false                    | 
| building_name      | string     | null: false                    | 
| phone_number       | string     | null: false                    | 
| profile            | text       | null: false                    | 
| store_image        |            | Active Storageで実装            |
| admin_user         | references | null: false, optional: true    |

### Association
- belongs_to :admin_user

## usersテーブル

| Column             | Types  | Options                    | 
| ------------------ | ------ | -------------------------- | 
| nickname           | string | null:false                 | 
| email              | string | null: false, unique: true  | 
| encrypted_password | string | null:false                 | 

### Association

- has_many :comments
- has_many :likes

## likesテーブル

| Column     | Types      | Options                      | 
| ---------- | ---------- | ---------------------------- | 
| event      | references | null:false, foreign_key:true | 
| user       | references | optional: true               | 
| admin_user | references | optional: true               |

### Association

- belongs_to :user
- belongs_to :admin_user
- belongs_to :event


## eventsテーブル

| Column          | Types      | Options                        | 
| --------------- | ---------- | ------------------------------ | 
| admin_user      | references | null: false, foreign_key: true | 
| name            | string     | null: false,                   | 
| content         | text       | null: false,                   | 
| event_date      | date       | null: false,                   | 
| event_image     |            | Active Storageで実装            | 


### Association
- belongs_to :admin_user
- has_many :comments
- has_many :likes


## commentsテーブル
| Column          | Types      | Options                        | 
| --------------- | ---------- | ------------------------------ | 
| event           | references | null: false, foreign_key: true | 
| user            | references | null: false, foreign_key: true | 
| text            | text       | null: false                    | 

### Association

- belongs_to :event
- belongs_to :user
