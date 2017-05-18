PARANAME='insert_to_parameter_group_name'

# Parameter Groupの一覧取得
aws rds describe-db-parameter-groups \
--query 'DBParameterGroups[].DBParameterGroupName'

# 特定のParameter Group設定を取得
aws rds describe-db-parameters \
--db-parameter-group-name ${PARANAME} \
--query 'Parameters[?ParameterValue!=`null`].{ParameterName:ParameterName, ParameterValue:ParameterValue}'

# 特定のParameter Group設定を取得し、json形式で保存
aws rds describe-db-parameters \
--db-parameter-group-name ${PARANAME} \
--query 'Parameters[?ParameterValue!=`null`].{ParameterName:ParameterName, ParameterValue:ParameterValue}' | \
jq -r 'sort_by(.ParameterName)' > ./outputs/${PARANAME}.json

# diffコマンドで差異を取得
diff -u *.json
