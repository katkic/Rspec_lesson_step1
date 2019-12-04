# Herokuへのデプロイ方法

- Ruby 2.6.5
- Rails 5.2.3
- PostgreSQL 12.1

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

この操作を行わないと、Herokuの環境でアセットファイルが全て読み込まれない。
開発環境では起動している時にアセットファイルをプリコンパイルして、そこでできた圧縮ファイルを読み込むが、本番環境では最初からあるアセットファイルしか読み込まれないため。

```
rails assets:precompile RAILS_ENV=production
git add -A
git commit -m "任意のコミットメッセージ"
git push heroku master
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

***

# テーブル構造

## usersテーブル
| カラム論理名   | カラム物理名 | データ型 |
| ----------   | -----------| :------ |
| ユーザーid    | id         | integer |
| ユーザー名    | name       | string  |
| メールアドレス | email      | string  |

## tasksテーブル
| カラム論理名 | カラム物理名 | データ型 |
| ---------- | -----------| :------ |
| タスクid    | id         | integer |
| タスク名     | name       | string  |
| タスク内容   | discription | text   |

## labelsテーブル
| カラム論理名 | カラム物理名 | データ型 |
| ---------- | -----------| :------ |
| ラベルid    | id         | integer |
| ラベル名    | name       | string   |

## labellingsテーブル
| カラム論理名 | カラム物理名 | データ型 |
| ---------- | -----------| :------ |
| ラベリングid | id         | integer |
| タスクid    | task_id    | string  |
| ラベルid    | label_id   | string  |