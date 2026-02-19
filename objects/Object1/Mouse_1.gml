var _data = {
    type: "login",
    username: "Player_167", // Testa med ett namn som du ser i din Dashboard!
    password: "123"
};

var _json = json_stringify(_data);
var _buf = buffer_create(string_byte_length(_json), buffer_fixed, 1);
buffer_write(_buf, buffer_text, _json);
network_send_raw(client_socket, _buf, buffer_tell(_buf));
buffer_delete(_buf);

show_debug_message("Försöker logga in...");