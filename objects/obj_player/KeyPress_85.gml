if (keyboard_check_pressed(ord("U"))) {
    var _new_color = choose(c_red, c_blue, c_green, c_yellow, c_white);
    image_blend = _new_color;

    //Create the package for the tunnel
    var _packet = {
        type: "broadcast",
        action: "change_color",   
        username: global.my_username,
        color: _new_color
    };

    gms_send_packet(_packet); 
    
    show_debug_message("Sent color change via tunnel!");
}