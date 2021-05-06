DOCKER_ORG := jbadams
DOCKER_REPO := md5-nf
DOCKER_TAG := 0.1.0
DOCKER_IMG := ${DOCKER_ORG}/${DOCKER_REPO}:${DOCKER_TAG}

Nothing:
	@echo "No target provided. Stop"

.PHONY: docker-build
docker-build:
	@docker image build -t ${DOCKER_IMG} .

.PHONY: docker-push
docker-push:
	@docker push ${DOCKER_IMG}

.PHONY: docker-build-push
docker-build-push: docker-build docker-push
