function verifyPlayerChoise() {
    let selectPlayer = document.getElementById("select-player");
    let newPlayer = document.getElementById("new-player");

    let selected = selectPlayer.selectedOptions[0].value;
    newPlayer.classList.toggle("hide", selected !== "new-player");

    if (selected === "select") {
        return false;
    }
    if (selected.startsWith("player/")) {
        return true
    }
    return newPlayer.value !== "";
}

function verifyJackChoice() {
    let elementList = document.getElementsByName("jack");
    for (let element of elementList) {
        if (element.checked) {
            return true;
        }
    }

    return false;
}

function verifyColorChoice() {
    var elementList = document.getElementsByName("color");
    for (let element of elementList) {
        if (element.checked) {
            return true;
        }
    }

    elementList = document.getElementsByName("jack");
    for (let element of elementList) {
        if (element.checked && element.value == "N") {
            return true;
        }
    }

    return false;
}

function verifyWinChoice() {
    let elementList = document.getElementsByName("win");
    for (let element of elementList) {
        if (element.checked) {
            return true;
        }
    }

    return false;
}

function verifyHandChoice() {
    let elementList = document.getElementsByName("hand");
    for (let element of elementList) {
        if (element.checked) {
            return true;
        }
    }

    return false;
}

function updateModifiers(target) {
    var hand = null;
    let elementList = document.getElementsByName("hand");
    for (let element of elementList) {
        if (element.checked) {
            hand = element.value;
        }
    }
    if (hand === null) {
        return
    }

    var isNull = false;


    let jackList = document.getElementsByName("jack");
    for (let element of jackList) {
        if (element.checked && element.value == "N") {
            var isNull = true;
        }
    }

    let checkSchneider = document.getElementById("mod-schneider");
    let checkSchneiderAngesagt = document.getElementById("mod-schneidera");
    let checkSchwarz = document.getElementById("mod-schwarz");
    let checkSchwarzAngesagt = document.getElementById("mod-schwarza");
    let checkOuvert = document.getElementById("mod-ouvert");

    if (isNull) {
        checkSchneider.parentElement.classList.toggle("hide", true);
        checkSchneiderAngesagt.parentElement.classList.toggle("hide", true);
        checkSchwarz.parentElement.classList.toggle("hide", true);
        checkSchwarzAngesagt.parentElement.classList.toggle("hide", true);
        checkOuvert.parentElement.classList.toggle("hide", false);

        return
    }

    if (target && target.value) {
        if (target == checkSchneider) {
            checkSchneiderAngesagt.checked = false;
            checkSchwarz.checked = false;
            checkSchwarzAngesagt.checked = false;
            checkOuvert.checked = false;
        }
        if (target == checkSchneiderAngesagt) {
            checkSchwarzAngesagt.checked = false;
            checkOuvert.checked = false;
        }
        if (target == checkSchwarz) {
            checkSchwarzAngesagt.checked = false;
            checkOuvert.checked = false;
        }
        if (target == checkSchwarzAngesagt) {
            checkOuvert.checked = false;
        }
    }

    if (hand === "no") {
        checkSchneider.parentElement.classList.toggle("hide", false);
        checkSchneiderAngesagt.parentElement.classList.toggle("hide", false);
        checkSchwarz.parentElement.classList.toggle("hide", false);
        checkSchwarzAngesagt.parentElement.classList.toggle("hide", false);
        checkOuvert.parentElement.classList.toggle("hide", false);

        if (checkOuvert.checked) {
            checkSchwarzAngesagt.checked = true;
        }
        if (checkSchwarzAngesagt.checked) {
            checkSchwarz.checked = true;
            checkSchneiderAngesagt.checked = true;
        }
        if (checkSchwarz.checked) {
            checkSchneider.checked = true;
        }
        if (checkSchneiderAngesagt.checked) {
            checkSchneider.checked = true;
        }
    } else {
        checkSchneider.parentElement.classList.toggle("hide", false);
        checkSchneiderAngesagt.parentElement.classList.toggle("hide", true);
        checkSchwarz.parentElement.classList.toggle("hide", false);
        checkSchwarzAngesagt.parentElement.classList.toggle("hide", true);
        checkOuvert.parentElement.classList.toggle("hide", true);
        
        checkSchneiderAngesagt.checked = false;
        checkSchwarzAngesagt.checked = false;
        checkOuvert.checked = false;

        if (checkSchwarz.checked) {
            checkSchneider.checked = true;
        }
    }
}

function refreshState() {
    let verfiyList = [
        verifyPlayerChoise,
        verifyJackChoice,
        verifyColorChoice,
        verifyWinChoice,
        verifyHandChoice
    ];

    let formPartList = document.getElementsByClassName("form-part");

    var index = 0;
    for (let verifier of verfiyList) {
        if (!verifier()) {
            break;
        }
        index += 1;
    }

    for (let i=0; i < formPartList.length; i++) {
        formPartList[i].classList.toggle("hide", i > index);
    }

    let jackList = document.getElementsByName("jack");
    for (let element of jackList) {
        if (element.checked && element.value == "N") {
            document.getElementById("color-choice").classList.add("hide");
        }
    }

    updateModifiers();
}

function init() {
    refreshState();

    for (let element of document.getElementsByTagName("input")) {
        element.addEventListener("change", (e) => {
            if (e.target.name.startsWith("mod-")) {
                updateModifiers(e.target);
            }
            refreshState();
        });
    }
    for (let element of document.getElementsByTagName("input")) {
        element.addEventListener("keyup", () => {
            refreshState();
        });
    }
    for (let element of document.getElementsByTagName("select")) {
        element.addEventListener("change", () => {
            refreshState();
        });
    }
}

window.addEventListener('load', () => {
    init();
});
