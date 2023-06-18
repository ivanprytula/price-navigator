####################################################################################################################
# Setup containers

build:
	docker compose -f docker-compose.yml -f docker-compose.dev.yml build

up:
	docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d

stop:
	docker compose -f docker-compose.yml -f docker-compose.dev.yml stop

down:
	docker compose -f docker-compose.yml -f docker-compose.dev.yml down

####################################################################################################################
# Testing, auto formatting, type checks, & Lint checks

pytest:
	docker exec -it price_navigator_local_django pytest -p no:warnings -v

format:
	docker exec price_navigator_local_django python -m black --config pyproject.toml .

isort:
	docker exec price_navigator_local_django isort .

type:
	docker exec price_navigator_local_django mypy --ignore-missing-imports price_navigator/

lint:
	docker exec price_navigator_local_django flake8

ci: isort format type lint pytest

####################################################################################################################
# Development

sh-django:
	docker exec -ti price_navigator_local_django bash

sh-db:
	docker exec -ti price_navigator_local_postgres bash

verify-db-health:
	docker exec -ti price_navigator_local_postgres psql -U postgres -c 'SELECT 1;'

psql-db:
	docker exec -ti price_navigator_local_postgres psql -U postgres

check-migrations-state:
	docker compose  -f docker-compose.yml -f docker-compose.dev.yml exec django python manage.py showmigrations -l --verbosity 2

createsuperuser:
	docker compose  -f docker-compose.yml -f docker-compose.dev.yml exec django python manage.py createsuperuser
