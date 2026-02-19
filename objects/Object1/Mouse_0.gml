var _data = {
    type: "register",
    username: "Player_" + string(irandom(1000)),
    password: "123"
};

var _json = json_stringify(_data);
var _buffer = buffer_create(string_byte_length(_json), buffer_fixed, 1);
buffer_write(_buffer, buffer_text, _json);

// Nu kommer GameMaker veta vad client_socket är!
network_send_raw(client_socket, _buffer, buffer_tell(_buffer));

buffer_delete(_buffer);