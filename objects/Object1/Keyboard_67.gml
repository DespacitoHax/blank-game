// Vi låtsas att du har en variabel som heter global.my_coins
global.my_coins += 10;

var _data = {
    type: "save_coins",
    username: "Player_121", // I ett riktigt spel använder du variabeln från inloggningen
    coins: global.my_coins
};

var _json = json_stringify(_data);
var _buf = buffer_create(string_byte_length(_json), buffer_fixed, 1);
buffer_write(_buf, buffer_text, _json);
network_send_raw(client_socket, _buf, buffer_tell(_buf));
buffer_delete(_buf);

show_debug_message("Skickade poäng till servern!");