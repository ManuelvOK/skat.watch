let add_game_dialog_state = 0;

let close_dialog_boxes = function() {
    let dialogs = document.getElementsByClassName("dialog");
    for (let dialog of dialogs) {
        dialog.classList.remove("active");
    }
    let dialog_wrapper = document.getElementsByClassName("dialog_wrapper")[0];
    dialog_wrapper.classList.remove("active");
}

let open_add_player_dialog = function(e) {
    e.stopPropagation();
    close_dialog_boxes();
    let dialog_wrapper = document.getElementsByClassName("dialog_wrapper")[0];
    dialog_wrapper.classList.add("active");
    let dialog = document.getElementById("add_player_dialog");
    dialog.classList.add("active");
}

let open_create_match_dialog = function(e) {
    e.stopPropagation();
    close_dialog_boxes();
    let dialog_wrapper = document.getElementsByClassName("dialog_wrapper")[0];
    dialog_wrapper.classList.add("active");
    let dialog = document.getElementById("create_match_dialog");
    dialog.classList.add("active");
}

let open_add_game_dialog = function(e) {
    e.stopPropagation();
    close_dialog_boxes();
    let dialog_wrapper = document.getElementsByClassName("dialog_wrapper")[0];
    dialog_wrapper.classList.add("active");
    let dialog = document.getElementById("add_game_dialog");
    dialog.classList.add("active");
    let sub_dialogs = dialog.getElementsByClassName("sub_dialog");
    add_game_dialog_state = 0;
    sub_dialogs[0].classList.add("active");
}

let add_game_dialog_next = function() {
    add_game_dialog_change_relative(1);
}

let add_game_dialog_previous = function() {
    add_game_dialog_change_relative(-1);
}

let add_game_dialog_change_relative = function(direction) {
    let dialog = document.getElementById("add_game_dialog");
    let sub_dialogs = dialog.getElementsByClassName("sub_dialog");
    sub_dialogs[add_game_dialog_state].classList.remove("active");
    add_game_dialog_state += direction;
    sub_dialogs[add_game_dialog_state].classList.add("active");
    let prevbutton = dialog.getElementsByClassName("prevbutton")[0];
    let nextbutton = dialog.getElementsByClassName("nextbutton")[0];
    let submitbutton = dialog.getElementsByClassName("submitbutton")[0];
    prevbutton.classList.toggle("active", add_game_dialog_state !== 0);
    nextbutton.classList.toggle("active", add_game_dialog_state !== sub_dialogs.length - 1);
    submitbutton.classList.toggle("active", add_game_dialog_state === sub_dialogs.length - 1);
}

let submit_add_game_dialog = function() {
    if (check_add_game_dialog()) {
        document.forms["add_game"].submit();
        return;
    }
    let button = document.getElementById("add_game_dialog").getElementsByClassName("submitbutton")[0];
    button.classList.add("red");
    setTimeout(function() {
        button.classList.remove("red");
    }, 2000);
}

let check_add_game_dialog = function() {
    let form = document.forms["add_game"];
    if (form["player"].value === '') {
        return false;
    }
    if (form["win"].value === '') {
        return false;
    }
    if (form["jack"].value === '') {
        return false;
    }
    if (form["color"].value === '') {
        return false;
    }
    return true;
}

let new_player = function() {
    document.getElementById("player_new").checked = true;
}
