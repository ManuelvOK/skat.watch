<html onclick="close_dialog_boxes();">
<head>
<script src="js/app.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>
    skat.watch
</title>
</head>
<body>
<header>

</header>

<nav>
    <ul>
        <!--
        <li onclick="open_add_player_dialog()">Spieler eintragen</li>
        <li onclick="open_create_match_dialog()">Match anlegen</li>
        -->
        <li onclick="open_add_game_dialog(event);">Spiel eintragen</li>
    </ul>
</nav>

<main>
    <div class="dialog_wrapper" onclick="event.stopPropagation();">
        <div class="dialog" id="add_player_dialog">
            <div class="close" onclick="close_dialog_boxes();">X</div>
            add_player
        </div>
        <div class="dialog" id="create_match_dialog">
            <div class="close" onclick="close_dialog_boxes();">X</div>
            create_match
        </div>
        <div class="dialog" id="add_game_dialog">
            <div class="close" onclick="close_dialog_boxes();">X</div>
            <form name="add_game" action="" method="post">
                <h3>Spiel eintragen</h3>
                <div class="sub_dialog" id="player_choice">
                    <h5>Spieler</h5>
                    <div class="choices">
                        <!-- TODO: players list gows here -->
                        <div>
                            <input type="radio" name="player" onclick="add_game_dialog_next();" value="alice" id="player_alice">
                            <label for="player_alice">Alice</label>
                        </div>
                        <div>
                            <input type="radio" name="player" onclick="add_game_dialog_next();" value="bob" id="player_bob">
                            <label for="player_bob">Bob</label>
                        </div>
                        <div>
                            <input type="radio" name="player" onclick="add_game_dialog_next();" value="mallory" id="player_mallory">
                            <label for="player_mallory">Mallory</label>
                        </div>
                        <div>
                            <input type="radio" name="player" value="new" id="player_new">
                            <label for="player_new"><input type="text" name="new_player_name" onclick="new_player()"></label>
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
                            <input type="radio" name="jack" value="-1" id="jack-1" onclick="add_game_dialog_next();">
                            <label for="jack-1">Ohne 1</label>
                        </div>
                        <div>
                            <input type="radio" name="jack" value="-2" id="jack-2" onclick="add_game_dialog_next();">
                            <label for="jack-2">Ohne 2</label>
                        </div>
                        <div>
                            <input type="radio" name="jack" value="-3" id="jack-3" onclick="add_game_dialog_next();">
                            <label for="jack-3">Ohne 3</label>
                        </div>
                        <div>
                            <input type="radio" name="jack" value="-4" id="jack-4" onclick="add_game_dialog_next();">
                            <label for="jack-4">Ohne 4</label>
                        </div>
                        <br>
                        <div>
                            <input type="radio" name="jack" value="1" id="jack1" onclick="add_game_dialog_next();">
                            <label for="jack1">Mit 1</label>
                        </div>
                        <div>
                            <input type="radio" name="jack" value="2" id="jack2" onclick="add_game_dialog_next();">
                            <label for="jack2">Mit 2</label>
                        </div>
                        <div>
                            <input type="radio" name="jack" value="3" id="jack3" onclick="add_game_dialog_next();">
                            <label for="jack3">Mit 3</label>
                        </div>
                        <div>
                            <input type="radio" name="jack" value="4" id="jack4" onclick="add_game_dialog_next();">
                            <label for="jack4">Mit 4</label>
                        </div>
                    </div>
                </div>
                <div class="sub_dialog" id="color_choice">
                    <h5>Gespielte Farbe</h5>
                    <div class="choices">
                        <div>
                            <input type="radio" name="color" onclick="add_game_dialog_next();" value="schell" id="color_schell">
                            <label for="color_schell">Schell</label>
                        </div>
                        <div>
                            <input type="radio" name="color" onclick="add_game_dialog_next();" value="herz" id="color_herz">
                            <label for="color_herz">Herz</label>
                        </div>
                        <div>
                            <input type="radio" name="color" onclick="add_game_dialog_next();" value="blatt" id="color_blatt">
                            <label for="color_blatt">Blatt</label>
                        </div>
                        <div>
                            <input type="radio" name="color" onclick="add_game_dialog_next();" value="eichel" id="color_eichel">
                            <label for="color_eichel">Eichel</label>
                        </div>
                        <div>
                            <input type="radio" name="color" onclick="add_game_dialog_next();" value="grand" id="color_grand">
                            <label for="color_grand">Grand</label>
                        </div>
                        <div>
                            <input type="radio" name="color" onclick="add_game_dialog_next();" value="null" id="color_null">
                            <label for="color_null">Null</label>
                        </div>
                    </div>
                </div>
                <div class="sub_dialog" id="mod_choice">
                    <h5>Spielmodifikationen</h5>
                    <div class="choices">
                        <div>
                            <input type="checkbox" value="hand" id="mod_hand">
                            <label for="mod_hand">Hand</label>
                        </div>
                        <div>
                            <input type="checkbox" value="ouvert" id="mod_ouvert">
                            <label for="mod_ouvert">Ouvert</label>
                        </div>
                        <div>
                            <input type="checkbox" value="schneider" id="mod_schneider">
                            <label for="mod_schneider">Schneider</label>
                        </div>
                        <div>
                            <input type="checkbox" value="schwarz" id="mod_schwarz">
                            <label for="mod_schwarz">Schwarz</label>
                        </div>
                    </div>
                </div>
                <input class="button nextbutton" type="button" value="Weiter" onclick="add_game_dialog_next();">
                <input class="button submitbutton" type="button" value="Absenden" onclick="submit_add_game_dialog()">
                <input class="button prevbutton" type="button" value="Zurück" onclick="add_game_dialog_previous()">
            </div>
        </form>
    </div>
    <table>
        <tr>
            <th>Spieler</th>
            <th>Punkte</th>
        </tr>
        % for score_item in scores:
        <tr>
            <td>${score_item["player"]}</td>
            <td>${score_item["score"]}</td>
        </tr>
        % endfor
    </table>
</main>

<footer>

</footer>
</body>
</html>
