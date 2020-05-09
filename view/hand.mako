<!DOCTYPE html>
<html onclick="close_dialog_boxes();">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="mobile-web-app-capable" content="yes">

    <link rel="stylesheet" type="text/css" href="static/css/hand.css">

    <title>skat.watch</title>
</head>

<body>
<main>
    <div class="hand_container">
        % for color, value in cards:
        <div class="card">
	        <img class="card_image" src="static/svg/${color}.svg" />
            <div class="value">
                ${value}
            </div>
        </div>
        % endfor
    </div>
</main>

<footer>

</footer>
</body>
</html>
