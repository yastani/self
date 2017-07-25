# 仕組み
本番・テスト環境の各サーバにインストールされているawslogsから
CloudwatchLogsに投げられたログをLambdaへストリーミングし
通知を要する文字列が含まれていた場合のみChatworkに投稿する。

# 設定ファイル
S3バケットにある「config.yml」を設定ファイルとして読み込んでいる。
編集する場合はこれを削除してからULすることで
それが完了した以降のタイミングから新たな設定をLambdaが読み取り反映されるようになる。
※つまりLambda側のコードは極力触る必要がない

## 記述ルール
- 通知先
    - webhook と同階層にslackなどを追加できる
- 対象環境
    - environments->test と同階層にstagingやproductionを追加できる
- 検出対象の文字列
    - match_words のリストに追加できる
- 通知を無視するLogStream
    - exclude_log_streams のリストに追加できる

# 新規に設定する場合
1. 新たなLambdaFunctionを追加する
    2. environment->variables に設定した環境変数の値とconfig.ymlが一致していること
1. AWSコンソールからCloudFormationを選択する
1. スタック「LogMonitorOfLambda」に編集したyamlを流し込む


1. AWSコンソールからAWS Lambdaを選択する
1. 新たに作成されたLambdaFunctionのトリガーに、ストリーミングしたいCloudwatchLogsを選択する
1. 選択時の値は下記の通り
  - Filter name：LogMonitor-{LogGroupName}
  - Filter pattern：（空白）
1. トリガー設定が完了したら、AWSコンソールからCloudwatch->logsを選択する
1. 該当するロググループに設定したLambdaFunctionが紐付いていることを確認する
1. 条件に合致したエラーがChatworkに通知されることを確認できれば完了

## コード変更時の対応
### config.ymlを変更する場合
※下記は「deploy.sh」を叩くことで省略可能
1. S3バケットに配置してある「config.yml」を削除
2. 編集した「config.yml」をアップロード

#### 注意点
1. config.ymlとLambdaFunctionの固有判定をLambdaの環境変数に依存させているためこれらの文字列は一致させなければ異常終了してしまう

### lambda_function.pyを変更する場合
※下記は「deploy.sh」を叩くことで省略可能
1. notifyToAnyErrorsディレクトリにて下記コマンドを実行
    2. `zip -r zipfiles/upload.zip *`
1. AWSコンソールからAWS Lambdaを選択する
2. コードエントリタイプ->.ZIPファイルをアップロードを選択
3. 対象のzipファイルをアップロードする

#### 注意点
1. Lambdaコンテナの標準パッケージに採用されていないpython moduleがいくつかあり
それらを包含してzip処理を施しているため、Lambda上でコード編集をしないこと
1. 新たにpython moduleを追加する場合は下記記事を参考にすること
    2. http://qiita.com/Hironsan/items/0eb5578f3321c72637b4