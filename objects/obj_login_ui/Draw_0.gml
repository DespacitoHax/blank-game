draw_set_halign(fa_center);
draw_text(room_width/2, 100, "LOGIN");

// Draw username
var _user_col = (selected == "user") ? c_yellow : c_white;
draw_text_color(room_width/2, 150, "Name: " + txt_username, _user_col, _user_col, _user_col, _user_col, 1);

// Draw password (as stars)
var _pass_col = (selected == "pass") ? c_yellow : c_white;
var _stars = string_repeat("*", string_length(txt_password));
draw_text_color(room_width/2, 200, "Pass: " + _stars, _pass_col, _pass_col, _pass_col, _pass_col, 1);

draw_text(room_width/2, 300, message);
draw_text(room_width/2, 500, "Ready-to-use source by GameCreationHUB");
draw_text(room_width/2, 550, "You're free to use this source however you'd like and release it as your own.");