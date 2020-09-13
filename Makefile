.PHONY: serve

GAMES = games.csv

vpath %.mako view

serve: index.html server
	./server

server:
	go build back/server.go

%.html: $(GAMES) %.mako
	python3 back/genhtml.py $^ > $@

$(GAMES):
	touch $@
