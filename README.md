# テーブル設計

## usersテーブル

| Column             | Types   | Options                    | 
| ------------------ | ------- | ---------------------------| 
| nickname           | string  |  null: false               | 
| email              | string  |  null: false, unique: true | 
| encrypted_password | string  |  null: false               | 


### Association
- has_many :verses
- has/many :comments
- has_one :admin


## adminsテーブル

| Column             | Types      | Options                    | 
| ------------------ | -------    | ---------------------------| 
| postal_code        | string     | null: false                | 
| prefecture_id      | integer    | null: false                | 
| municipality       | string     | null: false                | 
| address            | string     | null: false                | 
| building_name      | string     | null: false                | 
| phone_number       | string     | null: false                | 

### Association
- belongs_to :user, optional: true


## versesテーブル

| Column          | Types      | Options                        | 
| --------------- | ---------- | ------------------------------ | 
| user            | references | null: false, foreign_key: true | 
| content         | string     | null: false,                   | 


### Association
- belongs_to :user
- has_many :comments

## commentsテーブル
| Column          | Types      | Options                        | 
| --------------- | ---------- | ------------------------------ | 
| verse           | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |
| text            | string     | null: false                    | 


### Association

- belongs_to :verse
- belongs_to :user
