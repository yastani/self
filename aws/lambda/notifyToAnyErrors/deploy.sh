# S3Bucket名の入力
S3_BUCKET=hoge

# LambdaFunctionのコンテナに存在しないモジュールをローカルに取得
pip install requests -t .
pip install urllib3 -t .
pip install yaml -t .

# S3アップ用にZIP化
zip -r zipfiles/upload.zip *

# S3ファイル削除
aws s3 rm s3://$S3_BUCKET/ '*' -include '*' –recursive

# S3にアップロード
# *要認証済み
aws s3 cp ./zipfiles/upload.zip s3://$S3_BUCKET/ --acl public-read
aws s3 cp ./config.yml s3://$S3_BUCKET/ --acl authenticated-read