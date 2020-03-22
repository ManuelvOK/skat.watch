import random

cards = [ "Schell 7",
          "Schell 8",
          "Schell 9",
          "Schell 10",
          "Schell Unter",
          "Schell Ober",
          "Schell König",
          "Schell Ass",
          "Herz 7",
          "Herz 8",
          "Herz 9",
          "Herz 10",
          "Herz Unter",
          "Herz Ober",
          "Herz König",
          "Herz Ass",
          "Blatt 7",
          "Blatt 8",
          "Blatt 9",
          "Blatt 10",
          "Blatt Unter",
          "Blatt Ober",
          "Blatt König",
          "Blatt Ass",
          "Eichel 7",
          "Eichel 8",
          "Eichel 9",
          "Eichel 10",
          "Eichel Unter",
          "Eichel Ober",
          "Eichel König",
          "Eichel Ass" ]

def get_hand(player, seed=1337):
    random.seed(seed)
    current_game_cards = random.sample(cards, k=len(cards))
    return current_game_cards[player*10:player*10+10]
