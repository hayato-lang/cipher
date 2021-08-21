# Cipher
全国のライブハウスのイベント情報を閲覧することのできるアプリです。
<br>
ユーザー（ライブハウス管理者）は登録すると、イベント情報を投稿することができます。




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
- has_one :admin


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
| store_image       |            | Active Storageで実装            
| 
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user


## eventsテーブル

| Column          | Types      | Options                        | 
| --------------- | ---------- | ------------------------------ | 
| admin_user      | references | null: false, foreign_key: true | 
| name            | string     | null: false,                   |
| content         | text       | null: false,                   | 
| event_date      | date       | null: false,                   | 
| event_image     |            | Active Storageで実装            | 


### Association
- belongs_to :user
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
