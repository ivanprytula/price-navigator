.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

####################################################################################################################
# Setup containers

build: ## Build project with compose
	docker compose -f docker-compose.yml -f docker-compose.dev.yml build

up: ## Run project with compose
	docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d

stop:
	docker compose -f docker-compose.yml -f docker-compose.dev.yml stop

start:
	docker compose -f docker-compose.yml -f docker-compose.dev.yml start

down:
	docker compose -f docker-compose.yml -f docker-compose.dev.yml down

.PHONY: clean
clean: ## Clean Reset project containers and volumes with compose
	docker compose down -v --remove-orphans | true
	docker compose rm -f | true
	docker volume rm price-navigator-warehouse price-navigator-backups-dir-for-warehouse | true


####################################################################################################################
# Testing, auto formatting, type checks, & Lint checks

pytest: ## Run project tests
	docker exec -it price_navigator_local_django pytest -p no:warnings -v

format: ## Format project code.
	docker exec price_navigator_local_django python -m black --config pyproject.toml .

isort: ## Sort project imports.
	docker exec price_navigator_local_django isort .

type:  ## Static typing check
	docker exec price_navigator_local_django mypy --ignore-missing-imports price_navigator/

lint:  ## Lint project code.
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
