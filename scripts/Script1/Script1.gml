// Starta anslutningen och spara id:t i variabeln client_socket
client_socket = network_create_socket(network_socket_ws);
var _connected = network_connect_raw(client_socket, "127.0.0.1", 8080);

if (_connected < 0) {
    show_debug_message("Misslyckades att ansluta!");
} else {
    show_debug_message("Ansluten till servern!");
}