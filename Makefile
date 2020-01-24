.PHONY: serve

GAMES = games.csv

vpath %.mako view

serve: index.html
	python3 back/server.py $< static/js/app.js static/css/style.css $(GAMES)

%.html: $(GAMES) %.mako
	python3 back/genhtml.py $^ > $@

$(GAMES):
	touch $@
