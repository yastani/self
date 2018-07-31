#!/bin/bash
#
# 指定した環境のAMIを作成するスクリプト

if [ $# -ne 1 ]; then
  echo 'You must specify one Environment. Exit.'
  echo "Example: $0 stress1"
  exit 1
fi

function error {
  echo "$@" >&2
  exit 1
}

exec_dir="`dirname $0`/$1"
cd $exec_dir 2>/dev/null || error 'No Environment. exit.'

# provision用AMI作成
if [ -f template_provision.json ]; then
  template_provision_json=template_provision.json
else
  template_provision_json=../template_provision.json
fi

echo "[INFO] start to create ami for provision server."
packer build -var-file=common.json -var-file=provision.json $template_provision_json || error "$1環境用のprovisionサーバーのAMI作成に失敗しました。" &


# admin, batch, pubsub, web用AMI作成
for f in `ls *json | grep -v -e template -e provision -e common` ;do
  server_type=`echo $f | cut -f1 -d\.`

  if [ -f template.json ]; then
    template_json=template.json
  else
    template_json=../template.json
  fi

  echo "[INFO] start to create ami for $server_type server."
  packer build -var-file=common.json -var-file=$f $template_json || error "$1環境用の$server_typeサーバーのAMI作成に失敗しました。" &
done

wait
