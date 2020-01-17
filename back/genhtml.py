import logging
import re
import sys

from mako.template import Template
import itertools

def read_games(csv):
    for line in csv:
        try:
            timestamp, player, win, game = line[:-1].split(",")
            print(timestamp, player, win, game)
        except ValueError as e:
            logger.warning("invalid line: " + line[:-1])
        yield { "timestamp": timestamp,
                "player": player,
                "win": win,
                "game": game }

def points(game):
    # Get Null out of the way
    if game == "N":
        return 23
    elif game == "NH":
        return 35
    elif game == "NO":
        return 46
    elif game == "NOH":
        return 59
    spiel = int(game[1]) + 1
    mod = "tbhTBo".index(game[2]) + 1
    colour = (9, 10, 11, 12, 24)[int(game[3])]
    return (spiel + mod) * colour

def compute_scores(games):
    player_games = itertools.groupby(games, lambda g: g["player"])
    # TODO

def genhtml(templatefile, games):
    template = Template(filename=templatefile)
    return template.render(games)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("usage: {} <games> <template>".format(sys.argv[0]))
    logger = logging.getLogger()
    with open(sys.argv[1]) as gamesfile:
        games = read_games(gamesfile)
        scores = compute_scores(games)
        with open(sys.argv[2]) as templatefile:
            html = genhtml(templatefile, scores)
        print(html)
