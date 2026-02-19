draw_self();

draw_set_halign(fa_center);
draw_set_color(c_white);
var _display_name = (object_index == obj_player) ? global.my_username : username;
draw_text(x, y - 40, global.my_username);

if (chat_timer > 0) {
    draw_set_valign(fa_middle);
    
    var _w = string_width(chat_text) + 20;
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_roundrect(x - _w/2, y - 85, x + _w/2, y - 65, false);
    
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(x, y - 75, chat_text);
    
    chat_timer --;
}