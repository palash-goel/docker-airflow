.PHONY: run build

current_dir = $(shell pwd)

build:
	docker build --rm --build-arg AIRFLOW_DEPS="emr" -t puckel/docker-airflow .

run: build
	docker run -d -v ${current_dir}/requirements.txt:/requirements.txt -p 8080:8080 puckel/docker-airflow
	@echo airflow running on http://localhost:8080

run_raw:
	docker run -d -v ${current_dir}/requirements.txt:/requirements.txt -p 8080:8080 puckel/docker-airflow
	@echo airflow running on http://localhost:8080

logs:
	docker logs -f $(shell docker ps -q --filter ancestor=puckel/docker-airflow)

kill:
	@echo "Killing docker-airflow containers"
	docker kill $(shell docker ps -q --filter ancestor=puckel/docker-airflow)

tty:
	docker exec -i -t $(shell docker ps -q --filter ancestor=puckel/docker-airflow) /bin/bash
