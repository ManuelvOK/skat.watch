import logging
import sys
from datetime import datetime, date

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
    games = list(games)
    all_players = {game["player"] for game in games}

    old_score_factor = 0.5
    new_score_factor = 1

    # Get week of first game
    first_timestamp = date.fromtimestamp(int(games[0]["timestamp"]))
    first_year, first_week = first_timestamp.isocalendar()[:2]

    # Get current week
    current_timestamp = datetime.now()
    current_year, current_week = current_timestamp.isocalendar()[:2]

    # Get all weeks since the first game
    # [(2020, 1), (2020, 2), …]
    all_weeks_in_years = []
    for year in range(first_year, current_year + 1):
        start_week = first_week if year == first_year else 1
        end_week = current_week if year == current_year else date(year, 12, 28).isocalendar()[1]
        for week in range(start_week, end_week + 1):
            all_weeks_in_years.append((year, week))

    # Group all games by their week
    # {(2020,1): [game_1, game_2], …}
    games_grouped_by_week = {k: list(v) for k, v in itertools.groupby(
        games, key=lambda x: date.fromtimestamp(int(x["timestamp"])).isocalendar()[:2])}

    scores = {name: 0 for name in all_players}

    for year, week in all_weeks_in_years:
        games_in_week = games_grouped_by_week.get((year, week), [])

        scores_in_week = {name: 0 for name in all_players}
        for game in games_in_week:
            score = points(game["game"]) * (-2, 1)[int(game["win"])]
            scores_in_week[game["player"]] += score

        for name in all_players:
            scores[name] = scores[name] * old_score_factor + scores_in_week[name] * new_score_factor

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
