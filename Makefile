COMPOSER = docker run --rm -it -v $$PWD/application_tmp:/srv/app -w /srv/app -u $$(id -u):$$(id -g) composer:latest
PHP = docker run --rm -it -v $$PWD:/srv/app -w /srv/app -u $$(id -u):$$(id -g) php:8.1-alpine

create-laravel:
	mkdir -p application_tmp
	$(COMPOSER) create-project laravel/laravel . --stability=stable --prefer-dist --no-dev --no-progress --no-interaction
	rm -rf application_tmp/.git
	mv application_tmp/* ./
	rm -r application_tmp

update: composer.json
	$(COMPOSER) composer update

install: composer.lock
	$(COMPOSER) composer install

artisan:
	$(PHP) php artisan

phpunit:
	$(php) ./vendor/bin/phpunit tests
