PARANAME='insert_to_parameter-group-name'

# 特定のParameter Group設定を取得し、json形式で保存
aws rds describe-db-parameters \
--db-parameter-group-name ${PARANAME} \
--query 'Parameters[?ParameterValue!=`null`].{ParameterName:ParameterName, ParameterValue:ParameterValue}' | \
jq -r 'sort_by(.ParameterName)' > ./outputs/${PARANAME}.json

