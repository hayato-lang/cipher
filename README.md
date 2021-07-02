# テーブル設計

## admin_usersテーブル

| Column             | Types   | Options                    | 
| ------------------ | ------- | ---------------------------| 
| store_name         | string  |  null: false               | 
| email              | string  |  null: false, unique: true | 
| encrypted_password | string  |  null: false               | 
| store_image        |         | Active Storageで実装        | 

### Association
- has_many :verses
- has_many :comments
- has_one :admin


## adminsテーブル

| Column             | Types      | Options                        | 
| ------------------ | -------    | -------------------------------| 
| postal_code        | string     | null: false                    | 
| prefecture_id      | integer    | null: false                    | 
| municipality       | string     | null: false                    | 
| address            | string     | null: false                    | 
| building_name      | string     | null: false                    | 
| phone_number       | string     | null: false                    | 
| profile            | text       | null: false                    | 
| header_image       |            | Active Storageで実装            | 
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user


## versesテーブル

| Column          | Types      | Options                        | 
| --------------- | ---------- | ------------------------------ | 
| user            | references | null: false, foreign_key: true | 
| content         | text       | null: false,                   | 
| event_date      | date       | null: false,                   | 
| image           |            | Active Storageで実装            | 


### Association
- belongs_to :user
- has_many :comments

## commentsテーブル
| Column          | Types      | Options                        | 
| --------------- | ---------- | ------------------------------ | 
| verse           | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |
| text            | text       | null: false                    | 


### Association

- belongs_to :verse
- belongs_to :user
