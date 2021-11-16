test:
	bin/rails test -d

setup:
	bin/setup
	yarn install

db-reset:
	bin/rails db:drop
	bin/rails db:create
	bin/rails db:migrate

start:
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
	bin/rails db:fixtures:load || true

webpacker:
	bin/webpack-dev-server

.PHONY: test
