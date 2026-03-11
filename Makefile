lint:
	npx markdownlint-cli2 "**/*.md" --config .markdownlint.yml

check-links:
	lychee --exclude-loopback --exclude 'https://github.com/altertable-ai/.*' '**/*.md'

ci: lint check-links

.PHONY: lint check-links ci
