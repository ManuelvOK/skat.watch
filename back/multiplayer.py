import random

colors = [
    "schell",
    "herz",
    "blatt",
    "eichel"
]

values = [
    "7",
    "8",
    "9",
    "10",
    "U",
    "O",
    "K",
    "A"
]
color_count = len(colors)
value_count = len(values)
total_card_count = color_count * value_count


def get_card(card_id):
    color = colors[card_id // value_count]
    value = values[card_id % value_count]
    return color, value


def get_hand(player, seed=1337):
    random.seed(seed)
    # Shuffled list of all card identifiers
    current_game_cards = random.sample(range(total_card_count), k=total_card_count)

    # Pick 10 cards for the specified player
    player_cards = sorted(current_game_cards[player * 10:player * 10 + 10])

    return [get_card(card_id) for card_id in player_cards]
