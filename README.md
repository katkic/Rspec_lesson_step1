# テーブル構造

## usersテーブル
| カラム論理名   | カラム物理名 | データ型 |
| ----------   | -----------| ------- |
| ユーザーid    | id         | integer |
| ユーザー名    | name       | string  |
| メールアドレス | email      | string  |

## tasksテーブル
| カラム論理名 | カラム物理名 | データ型 |
| ---------- | -----------| ------- |
| タスクid    | id         | integer |
| タスク名     | name       | string  |
| タスク内容   | discription | text   |
| ステータス   | status      | integer |
| 優先順位     | priority    | integer |

## labelsテーブル
| カラム論理名 | カラム物理名 | データ型 |
| ---------- | -----------| ------- |
| ラベルid    | id         | integer |
| ラベル名    | name       | string   |

## labellingsテーブル
| カラム論理名 | カラム物理名 | データ型 |
| ---------- | -----------| ------- |
| ラベリングid | id         | integer |
| タスクid    | task_id    | string  |
| ラベルid    | label_id   | string  |

***
# Herokuへのデプロイ方法

## Herokuにログインする
Herokuへアップロードしたいアプリのディレクトリへ移動し、`heroku login`を実
行する
```
$ heroku login
```

## Herokuに新しいアプリケーションを作成する
`heroku create`を実行する
```
$ heroku create
```

## アセットプリコンパイルを実行する
```
rails assets:precompile RAILS_ENV=production
```

## Herokuにデプロイをする
RailsアプリケーションをHerokuにデプロイするには、まずGitを使ってHerokuにリポジトリをプッシュする。

```
$ git push heroku master
```
以下の表示がされればOK
```
remote: Verifying deploy... done.
```

## マイグレーションを実行し、テーブルを作成する
```
$ heroku run rails db:migrate
```

## アプリケーションにアクセスする
```
$ heroku open
```
または、URLを確認して入力する
#### HerokuアプリのURL

https://アプリ名.herokuapp.com/ のようになっている

#### アプリ名の確認方法
```
$ heroku config
=== dry-brook-21751 Config Vars
```
`heroku config`を実行すると、1行目にアプリ名が表示される
`dry-brook-21751`の部分がアプリ名になる