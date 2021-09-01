# Cipher
全国のライブハウスのイベント情報を閲覧することのできるアプリです。
<br>
ユーザー（ライブハウス管理者）は登録すると、イベント情報を投稿することができます。

<!-- ここにサイトの画像を載せる -->


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
- ユーザー登録、ログイン機能（devise）
- 投稿機能
  - イベント投稿(ActiveStorageを駆使し画像を含めて投稿)
- コメント機能(Ajax)

# テスト
- RSpec
  - 単体テスト(model)
  - 結合テスト(model)



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

## commentsテーブル
| Column          | Types      | Options                        | 
| --------------- | ---------- | ------------------------------ | 
| event           | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |
| text            | text       | null: false                    | 


### Association

- belongs_to :event
- belongs_to :user
