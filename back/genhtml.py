import logging
import re
import sys

from mako.template import Template
import itertools

def read_games(csv):
    for line in csv:
        try:
            timestamp, player, win, game = line[:-1].split(",")
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
    elif game == "Nh":
        return 35
    elif game == "No":
        return 46
    elif game == "Nho":
        return 59
    spiel = int(game[1]) + 1
    colour = (9, 10, 11, 12, 24)[int(game[2])]
    mod = len(game[3:])
    return (spiel + mod) * colour

def compute_scores(games):
    scores = {}
    for game in games:
        score = points(game["game"]) * (-2, 1)[int(game["win"])]
        scores[game["player"]] = scores.get(game["player"], 0) + score
    return scores

def genhtml(templatefile, scores):
    template = Template(filename=templatefile, input_encoding='utf-8')
    return template.render(players=scores.keys(), scores=scores)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("usage: {} <games> <template>".format(sys.argv[0]), file=sys.stderr)
    logger = logging.getLogger()
    with open(sys.argv[1]) as gamesfile:
        games = read_games(gamesfile)
        scores = compute_scores(games)
        html = genhtml(sys.argv[2], scores)
        print(html)
