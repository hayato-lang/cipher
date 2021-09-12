# Cipher
全国のライブハウスのイベント情報を閲覧することのできるアプリです。
<br>
ユーザー（ライブハウス管理者）は登録すると、イベント情報を投稿することができます。

[![Image from Gyazo](https://i.gyazo.com/9e3f0ac583032f29b2133627991c555a.gif)](https://gyazo.com/9e3f0ac583032f29b2133627991c555a)

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
- いいね機能


# テスト
- RSpec
  - 単体テスト(model)
  - 結合テスト(model)

# 実装した機能




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
| admin_user         | references | null: false, foreign_key: true |

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
- has_many :liked_posts, through: :likes, source: :event

## likesテーブル

| Column | Types      | Options                      | 
| ------ | ---------- | ---------------------------- | 
| event  | references | null:false, foreign_key:true | 
| user   | references | null:false, foreign_key:true | 

### Association

- belongs_to :user
- belongs_to :post


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
- has_many :liked_users, through: :likes, source: :user


## commentsテーブル
| Column          | Types      | Options                        | 
| --------------- | ---------- | ------------------------------ | 
| event           | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |
| text            | text       | null: false                    | 


### Association

- belongs_to :event
- belongs_to :user
