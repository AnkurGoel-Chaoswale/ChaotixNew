.PHONY: install
install:
	poetry install

.PHONY: install-pre-commit
install-pre-commit:
ifeq ($(OS),Windows_NT)
	cmd /c "poetry run pre-commit uninstall && poetry run pre-commit install"
else
	poetry run pre-commit uninstall; poetry run pre-commit install
endif

.PHONY:lint
lint:
	poetry run pre-commit run --all-files

.PHONY: migrate
migrate:
	poetry run python -m chaotixcore.manage migrate

.PHONY: migrations
migrations:
	poetry run python -m chaotixcore.manage makemigrations

.PHONY: run-server
run-server:
	poetry run python -m chaotixcore.manage runserver

.PHONY: make-app
make-app:
	poetry run python -m chaotixcore.manage startapp

.PHONY: superuser
superuser:
	poetry run python -m chaotixcore.manage createsuperuser

.PHONY: up-dependencies-only
up-dependencies-only:
	python -c "open('.env', 'a').close()"
	docker-compose -f docker-compose.dev.yml up --force-recreate redis

.PHONY: update
update: install migrate install-pre-commit
