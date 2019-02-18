# kaku_tail_uploader

とある映像作品の合作を行うための映像ファイルの提出先として、要件に合致する適当なオープンソースソフトウェアがなかったため作成したものです。

## 機能
- ユーザ登録
  - unauthorized, creator, staff, organizer, adminの5段階権限管理
    - 登録直後はunauthorized
    - 各ユーザは自身の一つ下の権限まで他のユーザを昇格させることができる
- ファイルのアップロード、ダウンロード
  - 署名付きURLを用いたs3バケットへのダイレクトアップロード、ダウンロード
  - 権限がunauthorizedであるユーザ
    - ファイルの一覧表示、アップロード、ダウンロード、削除のいずれもできない
  - 権限がcreatorであるユーザ
    - ファイルをアップロードできる
    - 自分がアップロードしたファイルのみが一覧表示、ダウンロードおよび削除できる
  - 権限がstaff以上であるユーザ
    - ファイルをアップロードできる
    - 自分以外がアップロードしたファイルも含め全てのファイルが一覧表示、ダウンロードおよび削除できる

## 必要環境
- Ruby 2.5.3
- Node.js v8.13.0 or later
- Amazon RDS(postgres)
  - 実際の運用は9.6.9で行った
- Amazon SES(us-west-2)
- Amazon S3バケット
- 上記SESとS3バケットに対して下記アクションが許可されたIAMロールを付与されたEC2インスタンス上で実行されること
  - SES
    - SES:SendEmail
    - SES:SendRawEmail
  - s3バケット
    - s3:PutObject
    - s3:GetObject
    - s3:DeleteObject

## セットアップ
```
bundle install --path vendor/bundle
yarn install
RAILS_ENV=production bundle ex rails assets:precompile
```

## Todo
- テストを書き足す

## LICENCE
This software is released under the MIT License.
