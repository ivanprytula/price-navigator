####################################################################################################################
# Setup containers

build:
	docker compose -f local.yml -f docker-compose.dev.yml build

up:
	docker compose -f local.yml -f docker-compose.dev.yml up -d

down:
	docker compose -f local.yml -f docker-compose.dev.yml down

sh-django:
	docker exec -ti price_navigator_local_django bash

sh-db:
	docker exec -ti price_navigator_local_postgres bash

####################################################################################################################
# Testing, auto formatting, type checks, & Lint checks

check-db:
	docker exec -ti price_navigator_local_postgres psql -U postgres -c 'SELECT 1;'

pytest:
	docker exec -it price_navigator_local_django pytest -p no:warnings -v

format:
	docker exec price_navigator_local_django python -m black --config pyproject.toml .

isort:
	docker exec price_navigator_local_django isort .

type:
	docker exec price_navigator_local_django mypy --ignore-missing-imports

lint:
	docker exec price_navigator_local_django flake8

ci: isort format type lint pytest
