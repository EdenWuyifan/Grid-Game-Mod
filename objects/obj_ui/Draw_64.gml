/// @description Insert description here
// You can write your code in this editor
draw_set_halign(fa_left);
draw_text_transformed_color(20,20,global.score_ai,1.25,1,0,c_white,c_white,c_white,c_white,1);

draw_text_transformed_color(20,wh-20,global.score_player,1.25,1,0,c_white,c_white,c_white,c_white,1);


draw_set_halign(fa_center);
draw_text_transformed_color(room_width/2,wh/2,"Current point: "+string(global.player_point),1.25,1,0,c_white,c_white,c_white,c_white,1);


if(global.state == global.state_count or global.state == global.state_match){
	if(global.player_point > 21){
		draw_text_transformed_color(room_width/2,room_height/2+100,"BUSTED!",1.25,1,0,c_red,c_red,c_red,c_red,1);
		global.player_enddraw = true;
	}
}