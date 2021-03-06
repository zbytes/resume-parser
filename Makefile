.PHONY: help
.DEFAULT_GOAL := help
help:
	@echo "---------------------------------------------------------------------------------------"
	@echo ""
	@echo "				Connexions Development CLI"
	@echo ""
	@echo "---------------------------------------------------------------------------------------"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Development

run: ## Run
	./mvnw clean install && java -jar target/resume-parser.jar

test: ## Test
	curl --request POST 'http://localhost:8080/upload' \
	--header 'Content-Type: multipart/form-data' \
	--form 'resume=@./Resumes/michael.pdf'

##@ Cloud - Docker

docker_login: ## Docker login
	echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin

docker_build: ## Docker build
	./mvnw clean install -Playertools

docker_publish: ## Docker publish
	docker run -d -p8080:8080 docker.io/zbytes/resume-parser-layertools:0.0.1

docker_run:  ## Docker run
	docker run -d -p8080:8080 docker.io/zbytes/resume-parser-layertools:0.0.1