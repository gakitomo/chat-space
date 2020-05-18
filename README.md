## usersテーブル

|Column|Type|Options|
|------|----|-------|
|Name|text|null: false|
|Email|string|null: false, unique: true|
|Password|string|null: false|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- has_many :users_groups
- has_many :groups through: users_groups
- has_many :messages

## groupsテーブル

|Column|Type|Options|
|------|----|-------|
|Name|text|null: false|
|Member|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- has_many :users_groups
- has_many :users through: users_groups
- has_many :messages

## users_groupsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group

## Messagesテーブル

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|image|text||
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group