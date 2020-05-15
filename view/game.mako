<!DOCTYPE html>
<html onclick="close_dialog_boxes();">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="mobile-web-app-capable" content="yes">

    <link rel="stylesheet" type="text/css" href="static/css/game.css">

    <title>skat.watch</title>
</head>

<body>
<main>
    <div class="bubble" id="player0">
        <a href="/quarantine?player=0&seed=${seed}">
            <div class="label">
                Player 0
            </div>
        </a>
    </div>
    <div class="bubble" id="player1">
        <a href="/quarantine?player=1&seed=${seed}">
            Player 1
        </a>
    </div>
    <div class="bubble" id="player2">
        <a href="/quarantine?player=2&seed=${seed}">
            Player 2
        </a>
    </div>
    <div class="bubble" id="skat">
        <a href="/quarantine?player=3&seed=${seed}">
            Skat
        </a>
    </div>
</main>

<footer>

</footer>
</body>
</html>
