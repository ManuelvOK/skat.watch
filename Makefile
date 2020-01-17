.PHONY: serve

GAMES = games.csv

serve: front/index.html
	python3 back/server.py $< front/js/app.js front/css/style.css $(GAMES)

%.html: $(GAMES) %.mako
	python3 back/genhtml.py $^ > $@

$(GAMES):
	touch $@
