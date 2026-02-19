// 1. SWITCH FIELD (TAB)
if (keyboard_check_pressed(vk_tab)) {
    selected = (selected == "user") ? "pass" : "user";
}

// 2. ERASE (BACKSPACE)
if (keyboard_check_pressed(vk_backspace)) {
    if (selected == "user") {
        txt_username = string_delete(txt_username, string_length(txt_username), 1);
    } else {
        txt_password = string_delete(txt_password, string_length(txt_password), 1);
    }
}

// 3. THE NEW WRITE METHOD (Forces letters)
if (keyboard_check_pressed(vk_anykey)) {
    // We filter out special keys so they don't print as strange characters
    var _c = keyboard_lastchar;
    
   // Only allow common characters (A-Z, 0-9, etc.)
    if (ord(_c) >= 32 && ord(_c) <= 126) {
        if (selected == "user") {
            if (string_length(txt_username) < 15) txt_username += _c;
        } else {
            if (string_length(txt_password) < 15) txt_password += _c;
        }
    }
}

// 4. LOGIN / REGISTER
if (keyboard_check_pressed(vk_enter)) {
    if (txt_username != "" && txt_password != "") {
        gms_login(txt_username, txt_password);
    }
}

if (keyboard_check_pressed(vk_escape)) {
     if (txt_username != "" && txt_password != "") {
        gms_register(txt_username, txt_password);
    }
}