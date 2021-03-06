.PHONY: help
.DEFAULT_GOAL := help
export MVN_CMD := ./mvnw -B -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn -V
help:
	@echo "---------------------------------------------------------------------------------------"
	@echo ""
	@echo "				Development CLI"
	@echo ""
	@echo "---------------------------------------------------------------------------------------"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Development

run: ## Run
	${MVN_CMD} clean install && java -jar target/resume-parser.jar

test: ## Test
	curl --request POST 'http://localhost:8080/upload' \
	--header 'Content-Type: multipart/form-data' \
	--form 'resume=@./Resumes/michael.pdf'

##@ Cloud - Docker

docker_login: ## Docker login
	echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin

docker_build: ## Docker build
	${MVN_CMD} clean install -Playertools

docker_publish: ## Docker publish
	docker run -d -p8080:8080 docker.io/zbytes/resume-parser:0.0.1

docker_run:  ## Docker run
	docker run -d -p8080:8080 docker.io/zbytes/resume-parser:0.0.1