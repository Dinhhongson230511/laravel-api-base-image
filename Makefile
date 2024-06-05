.PHONY: help

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

auth: ## auth with aws
	aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 178108053885.dkr.ecr.ap-southeast-1.amazonaws.com
build-push:
	make build
	make push
build: ## build image
	docker build -t laravel-api-base-image .
push: ## push image to ECR
	docker tag laravel-api-base-image:latest 178108053885.dkr.ecr.ap-southeast-1.amazonaws.com/laravel-api-base-image:latest
	docker push 178108053885.dkr.ecr.ap-southeast-1.amazonaws.com/laravel-api-base-image:latest