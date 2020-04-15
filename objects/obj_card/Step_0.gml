/// @description Insert description here
// You can write your code in this editor


//if we're in the matching state
//and the card is in the hand
//check to see if the mouse is over the card
//make that card the selected card
if(global.state == global.state_match && in_hand){
	if(position_meeting(mouse_x, mouse_y, id) and mouse_check_button_pressed(mb_left)){
		audio_play_sound(snd_flip,1,0);
		global.selected = id;
	}
	//else if (global.selected == id){
		//global.selected = noone;
	//}
}
