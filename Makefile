lint:
	npx markdownlint-cli2 "**/*.md" --config .markdownlint.yml

check-links:
	lychee --verbose --exclude-loopback '**/*.md'

ci: lint check-links

.PHONY: lint check-links ci
