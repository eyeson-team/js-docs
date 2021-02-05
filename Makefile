CMD=hugo

all: build deploy

watch:
	$(CMD) server -D

setup:
	git clone --depth 1 https://github.com/digitalcraftsman/hugo-material-docs.git themes/hugo-material-docs

build:
	$(CMD) --baseUrl="https://eyeson-team.github.io/js-docs" && \
		git ci -m "Public build `date -u`" public

deploy:
	git push origin main && git subtree push --prefix public origin gh-pages

.PHONY: all watch setup build deploy
