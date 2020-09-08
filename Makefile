PROJECT_NAME=dns-record-monitor
runtime_py=python3.8
handler_py=lambda_function.lambda_handler

ENV_FILE=.env
FUNC_DIR=dns-record-monitor
LAYER_DIR=twitter
TFVARS_JSON_FILE=terraform.tfvars.json

tf-init:
	cd terraform && \
	cp backup.tf.bak backup.tf && \
	sed -i.bak -e "s/<project-name>/$(PROJECT_NAME)/g" backup.tf && \
	sed -i '' -e "s/<profile>/$(AWS_PROFILE)/g" backup.tf && \
	terraform init

tf-fmt:
	cd terraform && \
	terraform fmt && \
	cd ..

tf-apply:
	cd terraform && \
	terraform workspace select $(WS) && \
	terraform apply && \
	cd ..

date:
	$(eval date_format := $(shell date -u "+%Y-%m-%dT%H:%M:00Z"))

test: date
	find opt/empty/ ! -name '.keep' -type f -exec rm -f {} + && \
	docker run --rm -v $(PWD)/src/$(FUNC_DIR):/var/task:ro,delegated -v $(PWD)/opt/$(LAYER_DIR):/opt:ro,delegated \
		--env-file $(ENV_FILE) lambci/lambda:$(runtime_py) ${handler_py} '{ "time": "$(date_format)" }'

get-bucket-name:
	$(eval bucket_name := $(shell cat $(TFVARS_JSON_FILE) | jq -r ".bucket_name.$(STAGE)"))
