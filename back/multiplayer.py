import random

colors = [
    "Schell",
    "Herz",
    "Blatt",
    "Eichel"
]

values = [
    "7",
    "8",
    "9",
    "10",
    "Unter",
    "Ober",
    "König",
    "Ass"
]


def get_hand(player, seed=1337):
    random.seed(seed)
    current_game_cards = random.sample(range(32), k=32)
    player_cards = current_game_cards[player * 10:player * 10 + 10]
    player_cards.sort()
    return [f"{colors[card // 8]} {values[card % 8]}" for card in player_cards]
