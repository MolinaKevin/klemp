.PHONY: test
test:
	docker-compose exec app ./vendor/bin/phpunit
dcs:
	docker-compose stop
dcu:
	docker-compose up -d
