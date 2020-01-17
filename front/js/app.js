let add_game_dialog_state = 0;

let close_dialog_boxes = function() {
    let dialogs = document.getElementsByClassName("dialog");
    for (let dialog of dialogs) {
        dialog.style.display = 'none';
    }
    let dialog_wrapper = document.getElementsByClassName("dialog_wrapper")[0];
    dialog_wrapper.style.display = 'none';
}

let open_add_player_dialog = function(e) {
    e.stopPropagation();
    close_dialog_boxes();
    let dialog_wrapper = document.getElementsByClassName("dialog_wrapper")[0];
    dialog_wrapper.style.display = 'block';
    let dialog = document.getElementById("add_player_dialog");
    dialog.style.display = 'block';
}

let open_create_match_dialog = function(e) {
    e.stopPropagation();
    close_dialog_boxes();
    let dialog_wrapper = document.getElementsByClassName("dialog_wrapper")[0];
    dialog_wrapper.style.display = 'block';
    let dialog = document.getElementById("create_match_dialog");
    dialog.style.display = 'block';
}

let open_add_game_dialog = function(e) {
    e.stopPropagation();
    close_dialog_boxes();
    let dialog_wrapper = document.getElementsByClassName("dialog_wrapper")[0];
    dialog_wrapper.style.display = 'block';
    let dialog = document.getElementById("add_game_dialog");
    dialog.style.display = 'block';
    let sub_dialogs = dialog.getElementsByClassName("sub_dialog");
    add_game_dialog_state = 0;
    sub_dialogs[0].style.display = 'block';
}

let add_game_dialog_next = function(e) {
    e.stopPropagation();
    add_game_dialog_change_relative(1);
}

let add_game_dialog_previous = function(e) {
    e.stopPropagation();
    add_game_dialog_change_relative(-1);
}

let add_game_dialog_change_relative = function(direction) {
    let dialog = document.getElementById("add_game_dialog");
    let sub_dialogs = dialog.getElementsByClassName("sub_dialog");
    sub_dialogs[add_game_dialog_state].style.display = 'none';
    add_game_dialog_state += direction;
    sub_dialogs[add_game_dialog_state].style.display = 'block';
    let prevbutton = dialog.getElementsByClassName("prevbutton")[0];
    let nextbutton = dialog.getElementsByClassName("nextbutton")[0];
    let submitbutton = dialog.getElementsByClassName("submitbutton")[0];
    prevbutton.style.display = add_game_dialog_state === 0 ? 'none' : 'inline';
    nextbutton.style.display = add_game_dialog_state === sub_dialogs.length - 1 ? 'none' : 'inline';
    submitbutton.style.display = add_game_dialog_state === sub_dialogs.length - 1 ? 'inline' : 'none';
}
