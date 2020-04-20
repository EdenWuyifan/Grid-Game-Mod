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
if (face_index == 1) sprite_index = spr_1;
else if (face_index == 2) sprite_index = spr_2;
else if (face_index == 3) sprite_index = spr_3;
else if (face_index == 4) sprite_index = spr_4;
else if (face_index == 5) sprite_index = spr_5;
else if (face_index == 6) sprite_index = spr_6;
else if (face_index == 7) sprite_index = spr_7;
else if (face_index == 8) sprite_index = spr_8;
else if (face_index == 9) sprite_index = spr_9;
else if (face_index == 10) sprite_index = spr_10;
if (face_up == false) sprite_index = spr_card;

draw_sprite(sprite_index, image_index, x, y);