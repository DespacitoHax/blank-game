// 1. NORMAL MOVEMENT (WASD)
var _speed = 4;
var _hmove = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _vmove = keyboard_check(ord("S")) - keyboard_check(ord("W"));

x += _hmove * _speed;
y += _vmove * _speed;

// 2. NETWORK SYNCH (Send to our Master Panel)
// We only send data if we have actually moved
if (_hmove != 0 || _vmove != 0) {
    gms_self_set_pos(x, y, sprite_index);
}