CMD=hugo

all: build deploy

watch:
		$(CMD) server -D

setup:
		git clone --depth 1 https://github.com/digitalcraftsman/hugo-material-docs.git themes/hugo-material-docs

build:
		$(CMD) && git ci -m "Public build `date -u`" public

deploy:
		git push origin master && git subtree push --prefix docs/public origin gh-pages

.PHONY: all watch setup build deploy
