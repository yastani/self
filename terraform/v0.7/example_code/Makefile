BUCKET_NAME = terraform-tfstate-centos7
REGION = ap-northeast-1
CD = [[ -d envs/${ENV} ]] && cd envs/${ENV}
ENV = $1
ARGS = $2
SHARED_CREDENTIALS_FILE = 'C:/Credentials/AWS/credentials'

terraform-get:
	@${CD} && \
		terraform get

terraform:
	@${CD} && \
		terraform ${ARGS}
 
remote-enable:
	@${CD} && \
		terraform remote config \
		-backend=s3 \
		-backend-config='bucket=${BUCKET_NAME}' \
		-backend-config='key=${ENV}/terraform.tfstate' \
		-backend-config='region=${REGION}' \
		-backend-config='shared_credentials_file=${SHARED_CREDENTIALS_FILE}' \
		-backend-config='profile=${ENV}'
 
remote-disable:
	@${CD} && \
		terraform remote config \
		-disable