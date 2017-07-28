# 事前準備

## キーペアの発行
新規キーペア「packer_temp_instance」をAWSコンソール上で発行しておくこと

## SSH秘密鍵の保管
新規キーペア登録時に発行されるSSH秘密鍵を「~/.ssh/aws_private_key」として保管しておくこと

# 実行コマンド
bin/packer build -on-error=ask -var-file=variables.json packer.json