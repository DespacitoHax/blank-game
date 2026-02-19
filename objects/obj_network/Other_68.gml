// 1. SECURITY CHECK: Kolla om det faktiskt är data vi fått
var _type = async_load[? "type"];
if (_type != network_type_data) exit; 

var _buff = async_load[? "buffer"];
if (_buff == undefined || buffer_get_size(_buff) <= 0) exit;

// 2. READ DATA
buffer_seek(_buff, buffer_seek_start, 0);
var _json = buffer_read(_buff, buffer_string); // Använd buffer_string för JSON

// 3. PARSE JSON
var _data;
try {
    _data = json_parse(_json);
} catch (_e) {
    show_debug_message("Corrupted packet received: " + string(_json));
    exit;
}

// 4. LOGIC FOR DIFFERENT PACKAGE TYPES

// --- LOGIN RESPONSE ---
if (_data.type == "login_res") {
    if (_data.success == true) {
        // Sätt coins och användarnamn
        global.my_coins = variable_struct_exists(_data, "coins") ? _data.coins : 0;
        
        if (variable_struct_exists(_data, "username")) {
            global.my_username = _data.username;
        } else if (instance_exists(obj_login_ui)) {
            global.my_username = obj_login_ui.txt_username;
        }
        
       // YOUR ADMIN PANEL LINK IS TYPED OUT HERE
        if (variable_struct_exists(_data, "admin_url")) {
            show_debug_message("==========================================");
            show_debug_message("YOUR PERSONAL CONTROL PANEL:");
            show_debug_message(_data.admin_url);
            show_debug_message("==========================================");
        }
        
        show_debug_message("Login successful! Name set to: " + global.my_username);
        room_goto(Room1); 
    } else {
        global.my_username = "Guest";
        var _msg = variable_struct_exists(_data, "msg") ? _data.msg : "Unknown error";
        show_message("Error: " + _msg);
    }
}

// MOVEMENT
if (_data.type == "player_moved") {
    if (_data.username == global.my_username) exit;

    if (!ds_map_exists(global.gms_other_players, _data.username)) {
        var _new = instance_create_layer(_data.x, _data.y, "Instances", obj_other_player);
        _new.username = _data.username;
        ds_map_add(global.gms_other_players, _data.username, _new);
    } else {
        var _p = global.gms_other_players[? _data.username];
        if (instance_exists(_p)) {
            _p.x = _data.x;
            _p.y = _data.y;
            _p.sprite_index = _data.sprite;
        }
    }
}

// UNIVERSAL BROADCAST
if (_data.type == "broadcast") {
    if (_data.action == "change_color") {
        var _sender = _data.username;
        if (ds_map_exists(global.gms_other_players, _sender)) {
            var _inst = global.gms_other_players[? _sender];
            if (instance_exists(_inst)) {
                _inst.image_blend = _data.color;
            }
        }
    }
}

// CHAT
if (_data.type == "chat_msg") {
    var _target = noone;
    if (_data.username == global.my_username) {
        if (instance_exists(obj_player)) _target = obj_player.id;
    } else {
        if (ds_map_exists(global.gms_other_players, _data.username)) {
            _target = global.gms_other_players[? _data.username];
        }
    }

    if (_target != noone && instance_exists(_target)) {
        _target.chat_text = _data.message;
        _target.chat_timer = 180; 
    }
}