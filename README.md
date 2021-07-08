# アプリ名
薪の掲示板  
https://haizai.herokuapp.com/  

# 概要
廃材を処分したい人と廃材を薪として利用したい人を繋げる掲示板アプリです。  
投稿者との連絡手段としてチャット機能が付いてます。
[![Image from Gyazo](https://i.gyazo.com/c393bbea82c4be92e04a3fa30a978652.gif)](https://gyazo.com/c393bbea82c4be92e04a3fa30a978652)
  
# Basic認証
ユーザー名：tzndk5ce  
パスワード：g4c3ide  

# テスト用アカウント
ユーザー名：yuta  
メールアドレス: yuta@gmail.com  
パスワード:test12  

ユーザー名：hanako  
メールアドレス: hanako@gmail.com  
パスワード:test12  



# 機能一覧
* ユーザー登録、ログイン機能(Devise)
* 投稿機能  
画像投稿(ActiveStorage MiniMagick ImageProcessing
)  
* タグ付け機能  
* 記事検索機能  
* チャット機能(Ajax)  
* ページネーション機能(Kaminari)
* サジェスト機能
* 新着メッセージ通知機能

# テスト
* Rspec
単体テスト

# 使用方法
### ユーザー登録  
1. ヘッダー右側の「ユーザー登録」をクリック

### ユーザーログイン
1. ヘッダー右側の「ログイン」をクリック  

### マイメニュー
1. ユーザーログインする  
2. ヘッダー右側に表示されるユーザー名にカーソルを合わせる
3.  ユーザーメニューが表示されるので「マイメニュー」をクリック


### 記事投稿  
1. ユーザー登録またはユーザーログインをする 
2. トップ画面右下にある「新規投稿」ボタンをクリック

### 投稿記事の編集削除  
1. ユーザーログイン後、マイメニューをクリック
2. 自身が投稿した記事一覧から編集したい記事の画像またはタイトルをクリックし記事詳細画面へ遷移。  
3. 編集または削除ボタンをクリック  

### 記事投稿者にメッセージを送る
1. ユーザーログインする
2. トップ画面から目的の記事の画像またはタイトルをクリックし記事詳細画面へ遷移
3. 「投稿者と連絡をとる」をクリックしメッセージ入力画面へ遷移
4. メッセージを入力し送信ボタンをクリック。新しいメッセージルームが作成される。
[![Image from Gyazo](https://i.gyazo.com/25d9b5b95ad885e30cfe8177564ec15e.gif)](https://gyazo.com/25d9b5b95ad885e30cfe8177564ec15e)
[![Image from Gyazo](https://i.gyazo.com/ad9f4b1401d350e934ad89e58b5cc3bc.gif)](https://gyazo.com/ad9f4b1401d350e934ad89e58b5cc3bc)

### メッセージを返信する
1. ユーザーログイン後、マイメニューをクリック
2. 「参加中のメッセージルーム」 から目的のメッセージルームをクリックしチャット画面へ遷移
3. 画面下部のメッセージ入力フォームにメッセージを入力し「送信」ボタンをクリック
[![Image from Gyazo](https://i.gyazo.com/9cbe902bfccd6c4e956a4eb9e42e529b.gif)](https://gyazo.com/9cbe902bfccd6c4e956a4eb9e42e529b)



### 記事検索
1. トップ画面上部にある記事検索フォームに検索したい項目を入力し「記事を検索」ボタンをクリック
2. タグ検索についてはスペースで区切ることによりAND検索が可能



# 環境
* Ruby 2.6.5
* Rails 6.0.3.6
* mysql 8.0.25
* jQuery


### 使用gem
* Devise  
* Rspec
* FactoryBot
* Kaminari
* aws-sdk-s3
* Faker
* MiniMagick
* ImageProcessing
* ActiveStorage

# こだわったところ
### タグ登録,検索時のサジェスト機能  
[![Image from Gyazo](https://i.gyazo.com/4c9ca8bf0d4174bb531ff4b14c38c65b.gif)](https://gyazo.com/4c9ca8bf0d4174bb531ff4b14c38c65b)

### 連動プルダウンリスト
提供場所（市区町村）入力時に、選択された都道府県に応じて市区町村のリスト内容が変化するよう実装しました。  

<a href="https://gyazo.com/b482333ca918cd3232dc4354e6609896"><img src="https://i.gyazo.com/b482333ca918cd3232dc4354e6609896.gif" alt="Image from Gyazo" width="1000"/></a>


# 課題
### メッセージ機能
ページを更新しないと新しいメッセージを受信することができない仕様になっているので、ActonCableを導入しリアルタイムでメッセージの送受信を行えるように開発中です。

### ビュー
レスポンシブデザインに対応中です。

### テストコード
単体



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
