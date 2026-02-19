draw_self(); // Draw the character first

// Draw the name (like we did before)
draw_set_halign(fa_center);
draw_set_color(c_white);
var _display_name = (object_index == obj_player) ? global.my_username : username;
draw_text(x, y - 40, _display_name);

// DRAW THE CHAT BUBBLE
if (chat_timer > 0) {
    draw_set_valign(fa_middle);
    
 // Draw a simple background for the text so it is visible
    var _w = string_width(chat_text) + 20;
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_roundrect(x - _w/2, y - 85, x + _w/2, y - 65, false);
    
    // Draw the text itself
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(x, y - 75, chat_text);
    
    chat_timer --; // Count down the time until the bubble disappears
}