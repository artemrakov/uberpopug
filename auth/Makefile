test:
	bin/rails test -d

compose-setup:
	make compose-down
	make compose-build
	docker-compose run --rm auth make setup
	docker-compose run --rm auth make db-prepare

setup:
	bin/setup
	yarn install

db-reset:
	bin/rails db:drop
	bin/rails db:create
	bin/rails db:migrate

start:
	rm -rf tmp/pids/server.pid
	bundle exec rails s -p 3000 -b '0.0.0.0'

clean:
	bin/rails db:drop

precompile-assets:
	bundle exec rails assets:precompile

db-prepare:
	bin/rails db:drop || true
	bin/rails db:create || true
	bin/rails db:schema:load || true
	bin/rails db:migrate || true

webpacker:
	bin/webpack-dev-server

compose:
	docker-compose up -d

compose-build:
	docker-compose build

compose-logs:
	docker-compose logs -f

compose-down:
	docker-compose down || true

compose-stop:
	docker-compose stop || true

compose-restart:
	docker-compose restart

.PHONY: test
