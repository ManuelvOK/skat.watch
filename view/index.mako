<!DOCTYPE html>
<html onclick="close_dialog_boxes();">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="mobile-web-app-capable" content="yes">

    <link rel="stylesheet" type="text/css" href="static/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;700&display=swap" rel="stylesheet"> 

    <title>skat.watch</title>
</head>

<body>
<nav>
    <div class="container">
        <a href="/enter"><button>Spiel eintragen</button></a>
    </div>
</nav>

<main>
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
</body>
</html>
