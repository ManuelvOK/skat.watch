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
        yield {"timestamp": timestamp,
               "player": player,
               "win": win,
               "game": game}


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

    # Get month of first game
    first_timestamp = date.fromtimestamp(int(games[0]["timestamp"]))
    first_year = first_timestamp.year
    first_month = first_timestamp.month

    # Get current month
    current_timestamp = datetime.now()

    current_year = current_timestamp.year
    current_month = current_timestamp.month

    # Get all months since the first game
    # [(2020, 1), (2020, 2), …]
    all_months_in_years = []
    for year in range(first_year, current_year + 1):
        start_month = first_month if year == first_year else 1
        end_month = current_month if year == current_year else 12
        for month in range(start_month, end_month + 1):
            all_months_in_years.append((year, month))

    # Group all games by their month
    # {(2020,1): [game_1, game_2], …}
    games_grouped_by_month = {k: list(v) for k, v in itertools.groupby(
        games,
        key=lambda x: (
            date.fromtimestamp(int(x["timestamp"])).year,
            date.fromtimestamp(int(x["timestamp"])).month
        ))}

    # {name: (score, total_score, months)}
    scores = {name: (0, 0, 0) for name in all_players}

    for year, month in all_months_in_years:
        games_in_month = games_grouped_by_month.get((year, month), [])

        # {name: (score_this_month, played_this_month)}
        scores_in_month = {name: (0, False) for name in all_players}
        for game in games_in_month:
            score = points(game["game"]) * (-2, 1)[int(game["win"])]
            old_score_in_month, _ = scores_in_month[game["player"]]
            scores_in_month[game["player"]] = (old_score_in_month + score, True)

        for name in all_players:
            old_score, old_total_score, months_not_played = scores[name]
            score_this_month, played_this_month = scores_in_month[name]

            new_score = old_score * old_score_factor + score_this_month * new_score_factor
            new_total_score = old_total_score + score_this_month
            months_not_played = 0 if played_this_month else months_not_played + 1

            scores[name] = (new_score, new_total_score, months_not_played)

    # {name: (score, total_score, months)}
    return scores


def compute_ranking(scores):
    active_scores = dict()
    inactive_scores = dict()
    for name, value in scores.items():
        if value[2] > 3:
            inactive_scores[name] = value
        else:
            active_scores[name] = value

    ranking = []
    for i, entry in enumerate(sorted(active_scores.items(), key=lambda x: x[1][0], reverse=True)):
        name, value = entry
        score, total_score, _ = value
        ranking.append((name, i + 1, ('%.1f' % round(score, 1)).replace(".", ","), total_score))

    inactive_players = []
    for i, entry in enumerate(sorted(inactive_scores.items(), key=lambda x: x[1][2])):
        name, value = entry
        score, total_score, months = value
        actual_months = months - 1
        if actual_months == 1:
            month_string = "1 Monat"
        else:
            month_string = "{} Monaten".format(actual_months)
        inactive_players.append((name, total_score, month_string))

    # ranking: (name, rank, score, total_score)
    # inactive_players: (name, total_score, inactive_time_string)
    return ranking, inactive_players


def genhtml(templatefile, scores):
    template = Template(filename=templatefile, input_encoding='utf-8')
    ranking, inactive_players = compute_ranking(scores)
    return template.render(players=sorted(scores.keys(), key=lambda x: x.lower()), ranking=ranking, inactive_players=inactive_players)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("usage: {} <games> <template>".format(sys.argv[0]), file=sys.stderr)
    logger = logging.getLogger()
    with open(sys.argv[1]) as gamesfile:
        games = read_games(gamesfile)
        scores = compute_scores(games)
        html = genhtml(sys.argv[2], scores)
        print(html)
