<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="mobile-web-app-capable" content="yes">

    <script src="static/js/new.js"></script>

    <link rel="stylesheet" type="text/css" href="static/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;700&display=swap" rel="stylesheet"> 

    <title>skat.watch</title>
</head>

<body>
<nav>
    <div class="container">
        <h1>Spiel eintragen</h1>
    </div>
</nav>

<main class="main-enter-game">
    <div class="container enter-game">
        <form name="add-game" action="/" method="post">
            <div class="form-part" id="player-choice">
                <h2>Spieler</h2>
                <select name="player" id="select-player">
                    <option value="select" selected="" disabled="">Spieler auswählen…</option>
                    % for player in players:
                    <option value="player/${player}">${player}</option>
                    % endfor
                    <option value="new-player">Neuer Spieler</option>
                </select>
                <input type="text" name="new-player" id="new-player" placeholder="Spielername" />
            </div>
            <div class="form-part" id="jack-choice">
                <h2>Unter auf der Hand</h2>
                <div class="choices">
                    <div>
                        <input type="radio" name="jack" value="O1" id="jack-1" />
                        <label for="jack-1">Ohne 1</label>
                    </div>
                    <div>
                        <input type="radio" name="jack" value="O2" id="jack-2" />
                        <label for="jack-2">Ohne 2</label>
                    </div>
                    <div>
                        <input type="radio" name="jack" value="O3" id="jack-3" />
                        <label for="jack-3">Ohne 3</label>
                    </div>
                    <div>
                        <input type="radio" name="jack" value="O4" id="jack-4" />
                        <label for="jack-4">Ohne 4</label>
                    </div>
                </div>
                <div class="choices">
                    <div>
                        <input type="radio" name="jack" value="M1" id="jack1" />
                        <label for="jack1">Mit 1</label>
                    </div>
                    <div>
                        <input type="radio" name="jack" value="M2" id="jack2" />
                        <label for="jack2">Mit 2</label>
                    </div>
                    <div>
                        <input type="radio" name="jack" value="M3" id="jack3" />
                        <label for="jack3">Mit 3</label>
                    </div>
                    <div>
                        <input type="radio" name="jack" value="M4" id="jack4" />
                        <label for="jack4">Mit 4</label>
                    </div>
                </div>
                <div class="choices">
                    <div>
                        <input type="radio" name="jack" value="N" id="jack-null" />
                        <label for="jack-null">Null</label>
                    </div>
                </div>
            </div>
            <div class="form-part" id="color-choice">
                <h2>Gespielte Farbe</h2>
                <div class="choices">
                    <div>
                        <input type="radio" name="color" value="0" id="color-schell" />
                        <label for="color-schell">Schell
                            <div><img src="static/svg/schell.svg" /></div>
                        </label>
                    </div>
                    <div>
                        <input type="radio" name="color" value="1" id="color-herz" />
                        <label for="color-herz">Herz
                            <div><img src="static/svg/herz.svg" /></div>
                        </label>
                    </div>
                    <div>
                        <input type="radio" name="color" value="2" id="color-blatt" />
                        <label for="color-blatt">Blatt
                            <div><img src="static/svg/blatt.svg" /></div>
                        </label>
                    </div>
                    <div>
                        <input type="radio" name="color" value="3" id="color-eichel" />
                        <label for="color-eichel">Eichel
                            <div><img src="static/svg/eichel.svg" /></div>
                        </label>
                    </div>
                    <div>
                        <input type="radio" name="color" value="4" id="color-grand" />
                        <label for="color-grand">Grand
                            <div><img src="static/svg/grand.svg" /></div>
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-part" id="win-choice">
                <h2>Spielausgang</h2>
                <div class="choices">
                    <div>
                        <input type="radio" name="win" value="win" id="win-win" />
                        <label for="win-win">Gewonnen</label>
                    </div>
                    <div>
                        <input type="radio" name="win" value="loose" id="win-loose" />
                        <label for="win-loose">Verloren</label>
                    </div>
                    <div>
                        <input type="radio" name="win" value="overbid" id="win-overbid" />
                        <label for="win-overbid">Überreizt</label>
                    </div>
                </div>
            </div>
            <div class="form-part" id="hand-choice">
                <h2>Hand oder nicht</h2>
                <div class="choices">
                    <div>
                        <input type="radio" name="hand" value="no" id="hand-no" checked="" />
                        <label for="hand-no">Skat aufgenommen</label>
                    </div>
                    <div>
                        <input type="radio" name="hand" value="yes" id="hand-yes" />
                        <label for="hand-yes">Hand</label>
                    </div>
                </div>
            </div>
            <div class="form-part" id="mod-choice">
                <h2>Spielmodifikationen</h2>
                <div class="choices">
                    <div>
                        <input type="checkbox" name="mod-t" value="t" id="mod-schneider" />
                        <label for="mod-schneider">Schneider</label>
                    </div>
                    <div>
                        <input type="checkbox" name="mod-T" value="T" id="mod-schneidera" />
                        <label for="mod-schneidera">Schneider angesagt</label>
                    </div>
                    <div>
                        <input type="checkbox" name="mod-b" value="b" id="mod-schwarz" />
                        <label for="mod-schwarz">Schwarz</label>
                    </div>
                    <div>
                        <input type="checkbox" name="mod-B" value="B" id="mod-schwarza" />
                        <label for="mod-schwarza">Schwarz angesagt</label>
                    </div>
                    <div>
                        <input type="checkbox" name="mod-o" value="o" id="mod-ouvert" />
                        <label for="mod-ouvert">Ouvert</label>
                    </div>
                </div>

                <input type="submit" value="Eintragen" />
            </div>
        </form>
    </div>
</main>
</body>
</html>
