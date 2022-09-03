setup:
	cp -n .env.example .env || true
	bin/setup

start:
	bin/dev

console:
	bin/rails console

sandbox:
	bin/rails console --sandbox

lint:
	bundle exec rubocop

fix:
	bundle exec rubocop -A

.PHONY: test