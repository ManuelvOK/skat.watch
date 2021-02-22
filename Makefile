.PHONY: serve rebuild force_update_games

GAMES = games.csv

vpath %.mako view

serve: index.html server
	./server

server:
	go build back/server.go

%.html: $(GAMES) %.mako
	python3 back/genhtml.py $^ > $@

rebuild: force_update_games index.html

force_update_games:
	touch $(GAMES)

$(GAMES):
	touch $@
