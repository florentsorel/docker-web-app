COMPOSER = docker run --rm -it -v $$PWD:/srv/app -w /srv/app -u $$(id -u):$$(id -g) composer:latest
PHP = docker run --rm -it -v $$PWD:/srv/app -w /srv/app -u $$(id -u):$$(id -g) php:8.1-alpine

create-laravel:
	mkdir -p application_tmp
	cd application_tmp && $(COMPOSER) create-project laravel/laravel . --stability=stable --prefer-dist --no-dev --no-progress --no-interaction
	cd ..
	rm -rf application_tmp/.git
	mv application_tmp/* ./
	mv application_tmp/.[!.]* ./
	rm -rf application_tmp

create-symfony-webapp:
	mkdir -p application_tmp
	cd application_tmp && $(COMPOSER) create-project symfony/skeleton . --stability=stable --prefer-dist --no-dev --no-progress --no-interaction
	rm -rf application_tmp/.git
	mv application_tmp/* ./
    mv application_tmp/.[!.]* ./
	rm -r application_tmp
    $(COMPOSER) composer require webapp

update:
	$(COMPOSER) composer update

artisan:
	$(PHP) php artisan

phpunit:
	$(php) ./vendor/bin/phpunit tests
