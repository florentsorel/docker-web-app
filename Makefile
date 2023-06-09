COMPOSER = docker run --rm -it -v $$PWD:/srv/app -w /srv/app -u $$(id -u):$$(id -g) composer:latest
PHP = docker run --rm -it -v $$PWD:/srv/app -w /srv/app -u $$(id -u):$$(id -g) php:8.2-alpine

.SILENT:
.IGNORE:

create-laravel:
	mkdir -p application_tmp
	cd application_tmp && $(COMPOSER) create-project laravel/laravel . --stability=stable --prefer-dist --no-progress --no-interaction
	cd ..
	rm -rf application_tmp/.git
	mv application_tmp/* ./
	mv application_tmp/.[!.]* ./
	rm -rf application_tmp

create-symfony-api:
	mkdir -p application_tmp
	cd application_tmp && $(COMPOSER) create-project symfony/skeleton . --stability=stable --prefer-dist --no-progress --no-interaction
	cd ..
	rm -rf application_tmp/.git
	mv application_tmp/* ./
	mv application_tmp/.[!.]* ./
	rm -rf application_tmp

create-symfony-webapp:
	mkdir -p application_tmp
	cd application_tmp && $(COMPOSER) create-project symfony/skeleton . --stability=stable --prefer-dist --no-progress --no-interaction
	cd ..
	rm -rf application_tmp/.git
	mv application_tmp/* ./
	mv application_tmp/.[!.]* ./
	rm -rf application_tmp
	$(COMPOSER) require webapp

composer:
	$(COMPOSER) $(filter-out $@,$(MAKECMDGOALS))

art:
	$(PHP) php artisan $(filter-out $@,$(MAKECMDGOALS))

sf:
	$(PHP) php bin/console $(filter-out $@,$(MAKECMDGOALS))

phpunit:
	$(PHP) ./vendor/bin/phpunit

# Docker
up:
	cd .docker && docker compose up -d && cd ..

down:
	cd .docker && docker compose down && cd ..

logs:
	cd .docker && docker compose logs && cd ..
%:
	@:
