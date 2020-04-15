/// @description Insert description here
// You can write your code in this editor

//if the card is not at the end position
//move a little bit closer to the end position
depth = targetdepth;
if (abs(x - target_x) > 1) {
	x = lerp(x,target_x,0.2);
}
else {
	x = target_x;
}
if (abs(y - target_y) > 1) {
	y = lerp(y,target_y,0.2);
}
else {
	y = target_y;
}

//assigns the face sprite depending on the card's face index 
if (face_index == 0) sprite_index = spr_rock;
if (face_index == 1) sprite_index = spr_paper;
if (face_index == 2) sprite_index = spr_scissors;
if (face_up == false) sprite_index = spr_card;

draw_sprite(sprite_index, image_index, x, y);