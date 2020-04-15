/// @description Insert description here
// You can write your code in this editor

draw_self(); //actually draw our button
draw_set_font(font0); //set our button font
draw_set_halign(fa_center); //align the font w/i the object to center
draw_set_valign(fa_center);

if(position_meeting(mouse_x, mouse_y, id)){ //if the mouse is over the button
	draw_set_color(c_white);
	if(image_index == 0){
		image_index = 1; //go to the blue sprite
		audio_play_sound(snd_flip,0,0);
	}
} else{
	draw_set_color(c_black);
	image_index = 0; //otherwise, stay on the white sprite
}
draw_text_transformed(x, y, myText,1,1,0); //draw the text in black
if(image_index == 1 && mouse_check_button_pressed(mb_left)){ //if we're hovering and we click the button
	if(myText == "START"){
		audio_play_sound(snd_win,0,0);
		room_goto_next(); //go to whatever room this button is connected to
	}else if(myText == "EXIT"){
		audio_play_sound(snd_lose,0,0);
		game_end();
	}
}