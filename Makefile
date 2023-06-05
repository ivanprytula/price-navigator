####################################################################################################################
# Setup containers

up:
	docker compose -f local.yml up --build -d

down:
	docker compose -f local.yml down

sh:
	docker exec -ti django bash

####################################################################################################################
# Testing, auto formatting, type checks, & Lint checks

pytest:
	docker exec webserver pytest -p no:warnings -v

format:
	docker exec webserver python -m black -S --line-length 79 .

isort:
	docker exec webserver isort .

type:
	docker exec webserver mypy --ignore-missing-imports

lint:
	docker exec webserver flake8

ci: isort format type lint pytest
