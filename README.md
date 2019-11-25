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
| ラベルid    | label_id   | string  |
