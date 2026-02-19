/// @function gms_init(game_id, ip_address)
function gms_init(_game_id, _ip) {
    // 1. Kolla om vi redan är anslutna
    if (variable_global_exists("gms_socket") && global.gms_socket != -1) exit;

    global.gms_game_id = _game_id;
    global.gms_socket = network_create_socket(network_socket_ws);
    
    // 2. FÖRSÖK ANSLUTA (Denna rad saknades!)
    var _res = network_connect_raw(global.gms_socket, _ip, 8080);
    
    global.gms_other_players = ds_map_create();
    
    // 3. Sätt bara till Guest om vi inte redan har ett namn
    if (!variable_global_exists("my_username")) {
        global.my_username = "Guest";
    }
    
    // 4. Kontrollera resultatet
    if (_res >= 0) {
        show_debug_message("✅ Ansluten till GMS Master!");
    } else {
        show_debug_message("❌ Kunde inte ansluta till servern.");
    }
}

/// @function gms_register(username, password)
function gms_register(_user, _pass) {
    var _data = {
        type: "register",
        game_id: global.gms_game_id,
        username: _user,
        password: _pass
    };
    gms_send_packet(_data);
}

/// @function gms_login(username, password)
function gms_login(_user, _pass) {
    global.my_username = _user;
    var _data = {
        type: "login",
        game_id: global.gms_game_id,
        username: _user,
        password: _pass
    };
    gms_send_packet(_data);
}
/// @function gms_chat_send(message)
function gms_chat_send(_msg) {
    var _data = {
        type: "chat",
        game_id: global.gms_game_id,
        username: global.my_username,
        message: _msg
    };
    gms_send_packet(_data);
}
/// @function gms_self_set_pos(x, y, sprite)
function gms_self_set_pos(_x, _y, _sprite) {
    var _data = {
        type: "update_pos",
        game_id: global.gms_game_id,
        username: global.my_username,
        x: _x,
        y: _y,
        sprite: _sprite
    };
    gms_send_packet(_data);
}

// Hjälpfunktion för att skicka paketen (Intern)
function gms_send_packet(_struct) {
    var _json = json_stringify(_struct);
    var _buf = buffer_create(string_byte_length(_json), buffer_fixed, 1);
    buffer_write(_buf, buffer_text, _json);
    network_send_raw(global.gms_socket, _buf, buffer_tell(_buf));
    buffer_delete(_buf);
}