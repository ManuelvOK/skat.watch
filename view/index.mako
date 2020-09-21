<!DOCTYPE html>
<html onclick="close_dialog_boxes();">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="mobile-web-app-capable" content="yes">

    <script src="static/js/app.js"></script>

    <link rel="stylesheet" type="text/css" href="static/css/style.css">
     <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;700&display=swap" rel="stylesheet"> 

    <title>skat.watch</title>
</head>

<body>
<nav>
    <div class="container">
        <button onclick="open_add_game_dialog(event);">Spiel eintragen</button>
    </div>
</nav>

<main>
    <div class="dialog_wrapper" onclick="event.stopPropagation();">
        <div class="dialog-window">
            <div class="dialog" id="add_player_dialog">
                <div class="close" onclick="close_dialog_boxes();">×</div>
                add_player
            </div>
            <div class="dialog" id="create_match_dialog">
                <div class="close" onclick="close_dialog_boxes();">×</div>
                create_match
            </div>
            <div class="dialog" id="add_game_dialog">
                <div class="dialog-header">
                    <h3>Spiel eintragen</h3>
                    <span class="close" onclick="close_dialog_boxes();">×</span>
                </div>
                <form name="add_game" action="" method="post">
                    <div class="sub_dialog" id="player_choice">
                        <h5>Spieler</h5>
                        <div class="choices">
                            % for player in players:
                            <div>
                                <input type="radio" name="player" onclick="add_game_dialog_next();" value="${player}" id=${"player_" + player}>
                                <label for=${"player_" + player}>${player}</label>
                            </div>
                            % endfor
                            <div>
                                <input type="radio" name="player" value="new" id="player_new">
                                <label for="player_new"><input type="text" name="new_player_name" onclick="new_player()" placeholder="Neuer Spieler"></label>
                            </div>
                        </div>
                    </div>
                    <div class="sub_dialog" id="win_choice">
                        <h5>Spielausgang</h5>
                        <div class="choices">
                            <div>
                                <input type="radio" name="win" onclick="add_game_dialog_next();" value="win" id="win_win">
                                <label for="win_win">Gewonnen</label>
                            </div>
                            <div>
                                <input type="radio" name="win" onclick="add_game_dialog_next();" value="loose" id="win_loose">
                                <label for="win_loose">Verloren</label>
                            </div>
                        </div>
                    </div>
                    <div class="sub_dialog" id="jack_choice">
                        <h5>Unter auf der Hand</h5>
                        <div class="choices">
                            <div>
                                <input type="radio" name="jack" value="O1" id="jack-1" onclick="add_game_dialog_next();">
                                <label for="jack-1">Ohne 1</label>
                            </div>
                            <div>
                                <input type="radio" name="jack" value="O2" id="jack-2" onclick="add_game_dialog_next();">
                                <label for="jack-2">Ohne 2</label>
                            </div>
                            <div>
                                <input type="radio" name="jack" value="O3" id="jack-3" onclick="add_game_dialog_next();">
                                <label for="jack-3">Ohne 3</label>
                            </div>
                            <div>
                                <input type="radio" name="jack" value="O4" id="jack-4" onclick="add_game_dialog_next();">
                                <label for="jack-4">Ohne 4</label>
                            </div>
                            <br>
                            <div>
                                <input type="radio" name="jack" value="M1" id="jack1" onclick="add_game_dialog_next();">
                                <label for="jack1">Mit 1</label>
                            </div>
                            <div>
                                <input type="radio" name="jack" value="M2" id="jack2" onclick="add_game_dialog_next();">
                                <label for="jack2">Mit 2</label>
                            </div>
                            <div>
                                <input type="radio" name="jack" value="M3" id="jack3" onclick="add_game_dialog_next();">
                                <label for="jack3">Mit 3</label>
                            </div>
                            <div>
                                <input type="radio" name="jack" value="M4" id="jack4" onclick="add_game_dialog_next();">
                                <label for="jack4">Mit 4</label>
                            </div>
                            <div>
                                <!-- TODO hier sollte woanders hingesprungen werden -->
                                <input type="radio" name="jack" value="N" id="jack_null" onclick="add_game_dialog_next();">
                                <label for="jack_null">Null</label>
                            </div>
                        </div>
                    </div>
                    <div class="sub_dialog" id="color_choice">
                        <h5>Gespielte Farbe</h5>
                        <div class="choices">
                            <div>
                                <input type="radio" name="color" onclick="add_game_dialog_next();" value="0" id="color_schell">
                                <label for="color_schell">Schell
                                    <img src="static/svg/schell.svg" />
                                </label>
                            </div>
                            <div>
                                <input type="radio" name="color" onclick="add_game_dialog_next();" value="1" id="color_herz">
                                <label for="color_herz">Herz
                                    <img src="static/svg/herz.svg" />
                                </label>
                            </div>
                            <div>
                                <input type="radio" name="color" onclick="add_game_dialog_next();" value="2" id="color_blatt">
                                <label for="color_blatt">Blatt
                                    <img src="static/svg/blatt.svg" />
                                </label>
                            </div>
                            <div>
                                <input type="radio" name="color" onclick="add_game_dialog_next();" value="3" id="color_eichel">
                                <label for="color_eichel">Eichel
                                    <img src="static/svg/eichel.svg" />
                                </label>
                            </div>
                            <div>
                                <input type="radio" name="color" onclick="add_game_dialog_next();" value="4" id="color_grand">
                                <label for="color_grand">Grand
                                    <img src="static/svg/grand.svg" />
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="sub_dialog" id="mod_choice">
                        <h5>Spielmodifikationen</h5>
                        <div class="choices">
                            <div>
                                <input type="checkbox" name="mod_t" value="t" id="mod_schneider">
                                <label for="mod_schneider">Schneider</label>
                            </div>
                            <div>
                                <input type="checkbox" name="mod_b" value="b" id="mod_schwarz">
                                <label for="mod_schwarz">Schwarz</label>
                            </div>
                            <div>
                                <input type="checkbox" name="mod_h" value="h" id="mod_hand">
                                <label for="mod_hand">Hand</label>
                            </div>
                            <div>
                                <input type="checkbox" name="mod_T" value="T" id="mod_schneidera">
                                <label for="mod_schneidera">Schneider angesagt</label>
                            </div>
                            <div>
                                <input type="checkbox" name="mod_B" value="B" id="mod_schwarza">
                                <label for="mod_schwarza">Schwarz angesagt</label>
                            </div>
                            <div>
                                <input type="checkbox" name="mod_o" value="o" id="mod_ouvert">
                                <label for="mod_ouvert">Ouvert</label>
                            </div>
                        </div>
                    </div>
                    <div class="dialog-footer">
                        <input class="button nextbutton active" type="button" value="Weiter" onclick="add_game_dialog_next();">
                        <input class="button submitbutton" type="button" value="Absenden" onclick="submit_add_game_dialog()">
                        <input class="button prevbutton" type="button" value="Zurück" onclick="add_game_dialog_previous()">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="container">
        <ul>
            % for name, rank, score, totalScore in ranking:
            <li>
                <div>
                    <span class="rank">${"🏆" if rank == 1 else rank}</span>
                </div>
                <div>
                    <span class="name">${name}</span>
                    <span class="total-score">Gesamtpunktzahl: ${totalScore}</span>
                </div>
                <div>
                    <span class="score">${score}</span>
                </div>
            </li>
            % endfor
        </ul>
        <span>Inaktive Spieler</span>
        <ul class="inactive-players">
            % for name, totalScore, week_string in inactive_players:
            <li>
                <div>
                    <span class="rank">-</span>
                </div>
                <div>
                    <span class="name">${name}</span>
                    <span class="total-score">Gesamtpunktzahl: ${totalScore}</span>
                </div>
                <div>
                    <span class="text-inactive">inaktiv seit</span>
                    <span class="time-inactive">${week_string}</span>
                </div>
            </li>
            % endfor
        </ul>
    </div>
</main>

<footer>

</footer>
</body>
</html>
