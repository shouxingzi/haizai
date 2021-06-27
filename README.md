# アプリ名
廃材掲示板アプリ  
  
# 概要
廃材を処分したい人と廃材を薪として利用したい人を繋げる掲示板アプリです。

# 開発背景
我が家は薪ストーブユーザーであり、近所の住民も薪ストーブを使っているお宅が多いです。  
薪ストーブの火はやわらかく体の芯から温めてくれるので冬場には欠かせない優れた暖房器具ですが、その分薪の調達が大変だというデメリットもあります。  
薪の購入費用は高く、持ち山がない薪ストーブユーザーは薪の調達に苦労します。一方で、倒木や庭の剪定で出た材木を処分したい人たちもいます。  
そんな人たちの需要と供給をマッチングできる掲示板アプリがあれば良いなと思いこのアプリを制作することにしました。


# ペルソナ
* 30代〜60代の薪ストーブユーザー  
* 自宅に庭がある人  
* 持ち山がある人

# 機能
* ユーザー管理機能
* 投稿機能  
* 投稿編集機能  
* タグ付け機能  
* 検索機能  
* メッセージ機能  

# 環境

# こだわったところ
複数タグの投稿、編集機能  

タグ登録時のサジェスト機能  
[![Image from Gyazo](https://i.gyazo.com/4c9ca8bf0d4174bb531ff4b14c38c65b.gif)](https://gyazo.com/4c9ca8bf0d4174bb531ff4b14c38c65b)

記事検索機能  

連動プルダウンメニュー  

<a href="https://gyazo.com/b482333ca918cd3232dc4354e6609896"><img src="https://i.gyazo.com/b482333ca918cd3232dc4354e6609896.gif" alt="Image from Gyazo" width="1000"/></a>
メッセージ機能  

新着通知機能  

# 課題
## メッセージ機能
ページを更新しないと新しいメッセージを受信することができない仕様になっているので、ActonCableを導入しリアルタイムでメッセージの送受信を行えるように開発中です。

## ビュー
レスポンシブデザインに対応中です。

## 画像投稿機能
現状では1つの画像しかアップロードできないため複数画像をアップロード出来るように開発中です。



# データベース設計

## users

| Column             | Type   | Options                   |
| ------------------ | -------| ------------------------- |
| username           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | s
tring | null: false               |

### Association
- has_many :tweets
- has_many :room_users
- has_many :rooms, through room_users
- has_many :messages



## tweets

| Column          | Type       | Options                        |
| --------------- | -------    | ------------------------------ |
| title           | string     | null: false                    |
| text            | text       | null: false                    |
| prefecture      | references | null: false, foreign_key: true |
| city            | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- belongs_to :prefecture
- belongs_to :city
- has_many :rooms, dependent destroy
- has_many :tweet_tag_relations, dependent destroy
- has_many :tags, through tweet_tag_relations
- has_one_attached :image


## prefectures

| Column        | Type    | Options     |
| ------------- | ------- | ------------|
| prefecture    | string  | null: false |        


### Association
- has_many :tweets


## cities

| Column         | Type    | Options     |
| -------------- | ------- | ------------|
| city           | string  | null: false |        
| prefecture_id  | integer | null: false |


### Association
- has_many :tweets



## tweet_tag_relations

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| tweet          | references | null: false, foreign_key: true |
| tag            | references | null: false, foreign_key: true |


### Association
- belongs_to :tweet
- belongs_to :tag



## tags
| Column     | Type       | Options     |
| ---------- | ---------- | ----------- |
| name       | string     | null: false |

### Association
- has_many :tweet_tag_relations
- has_many :tweets, through tweet_tag_relations


## rooms

| Column          | Type       | Options                        |
| --------------- | -------    | ------------------------------ |
| room_name       | string     | null: false                    |
| tweet           | references | null: false, foreign_key: true |


### Association
- has_many :room_users, dependent destroy
- has_many :users, through room_users
- has_many :messages, dependent destroy
- belongs_to :tweet


## room_users

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| room          | references | null: false, foreign_key: true |
| user          | references | null: false, foreign_key: true |


### Association
- belongs_to :room
- belongs_to :user


## messages

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| content       | text       |                                |
| room          | references | null: false, foreign_key: true |
| user          | references | null: false, foreign_key: true |
| checked       | boolean    | null: false, default: false |


### Association
- belongs_to :user
- belongs_to :room

## images(ActiveStorage)
