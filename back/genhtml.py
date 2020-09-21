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

    scores = {name: (0, 0, 0) for name in all_players}

    for year, week in all_weeks_in_years:
        games_in_week = games_grouped_by_week.get((year, week), [])

        scores_in_week = {name: (0, False) for name in all_players}
        for game in games_in_week:
            score = points(game["game"]) * (-2, 1)[int(game["win"])]
            old_score_in_week, _ = scores_in_week[game["player"]]
            scores_in_week[game["player"]] = (old_score_in_week + score, True)

        for name in all_players:
            old_score, old_total_score, weeks_not_played = scores[name]
            score_this_week, played_this_week = scores_in_week[name]
            new_score = old_score * old_score_factor + score_this_week * new_score_factor
            new_total_score = old_total_score + score_this_week
            weeks_not_played = 0 if played_this_week else weeks_not_played + 1
            scores[name] = (new_score, new_total_score, weeks_not_played)

    return scores


def genhtml(templatefile, scores):
    template = Template(filename=templatefile, input_encoding='utf-8')
    # name: (score, total_score, weeks)
    active_scores = dict()
    inactive_scores = dict()
    for name, tup in scores.items():
        if tup[2] >= 13:
            inactive_scores[name] = tup
        else:
            active_scores[name] = tup

    # (name, rank, score, total_score)
    ranking = []
    for i, entry in enumerate(sorted(active_scores.items(), key=lambda x: x[1][0], reverse=True)):
        name, tup = entry
        score, total_score, _ = tup
        ranking.append((name, i + 1, score, total_score))

    inactive_players = []
    for i, entry in enumerate(sorted(inactive_scores.items(), key=lambda x: x[1][2])):
        name, tup = entry
        score, total_score, _ = tup
        inactive_players.append((name, total_score))

    return template.render(players=scores.keys(), ranking=ranking, inactive_players=inactive_players)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("usage: {} <games> <template>".format(sys.argv[0]), file=sys.stderr)
    logger = logging.getLogger()
    with open(sys.argv[1]) as gamesfile:
        games = read_games(gamesfile)
        scores = compute_scores(games)
        html = genhtml(sys.argv[2], scores)
        print(html)
