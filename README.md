# Medpeer


## 概要
アイデアを管理するAPI

- アイデアを保存することができます。
- アイデアをカテゴリー分けすることができます。
- カテゴリー別でアイデア検索ができます。


## 利用方法

### アイデア投稿

リクエスト先(POST): http://localhost:3000/ideas (Prefix:ideas)

リクエスト(JSON)

{
  "idea": {
    "name": "category",
    "body": "idea"
  }    
}

### カテゴリーに紐づくアイデア一覧取得

リクエスト先(GET): http://localhost:3000/ideas/search (Prefix:search_ideas)

リクエスト(JSON)

{
  "category_name": "category"
}


## 機能一覧

- アイデア投稿機能
- カテゴリー分け機能
- カテゴリーに紐づくアイデア検索機能


## 使用技術

- Ruby(2.6.5) / Ruby on Rails(6.0.0) / Mysql(5.6)
- Rubocop / Rspec
- Git / GitHub / Visual Studio Code


## 工夫したポイント

- DRYを意識したコードの実装
- Formオブジェクトを用いたモデル設計
- トランザクション処理を用いた、保守性の担保
- Rspecテストコードの実装（モデル単体テスト・コントローラー単体テスト)
- Postmanを用いたapi機能確認


## 課題点と疑問点

- ストロングパラメーター設定においてrequireすべきなのか? 外部apiとしては使用しづらくなる為不要? 実装自体はideaモデルをrequireしております。
- Rails apiモードの際の仕様をもっと理解すべきだと思いました。（ローカル変数やインスタンス変数の取り扱い、レスポンスのデータ内容など)


## ER図
![Medpeer](https://user-images.githubusercontent.com/75054906/111060175-547cc000-84de-11eb-83f9-d8c66ec9a0ab.png)


## テーブル設計

## categories テーブル

| Column | Type   | Options      |
| ------ | ------ | ------------ |
| name   | string | null: false  |
| name   | index  | unique: true |

### Association

- has_many :ideas


## ideas テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| body     | text       | null: false                    |
| category | references | null: false, foreign_key: true |

### Association

- belongs_to :category
