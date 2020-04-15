
//this is our state machine
//we're using a switch case statement
//switch case statements are a clearer form of conditionals
//this replaces using a bunch of if else statments


switch(global.state){//switch condition based on the state we're on
  case global.state_deal://if we're in the deal state
    var cards_in_hand = ds_list_size(global.hand);
    if (cards_in_hand < 3){//if we have less than 3 cards in our hand
	  dealt_timer++;
	  if(dealt_timer>=global.game_speed){
		  if(dealt_side == 0){
			  audio_play_sound(snd_flip,1,0);
			  var dealt_card_ai = global.deck[| 0];
			  ds_list_delete(global.deck, 0);
			  ds_list_add(global.hand_ai, dealt_card_ai);
			  dealt_card_ai.target_x = room_width/3  + cards_in_hand * 100;
			  dealt_card_ai.target_y = room_height*1/6;
			  dealt_card_ai.in_hand = true;
			  dealt_card_ai.side = 2;
			  dealt_side = 1;
			  dealt_timer = 0;
		  }else{
			  audio_play_sound(snd_flip,1,0);
			  var dealt_card = global.deck[| 0]; //get a card from the deck
			  ds_list_delete(global.deck, 0); //remove it from the deck
		      ds_list_add(global.hand, dealt_card); //add it to the hand
			  dealt_card.target_x = room_width/3  + cards_in_hand * 100; //set its target position
		      dealt_card.target_y = room_height*5/6;
			  dealt_card.in_hand = true; //tell the card its in the hand
			  dealt_card.face_up = true;
			  ds_list_add(global.face_up_cards, dealt_card);
			  dealt_card.side = 1;
			  dealt_side = 0;
			  dealt_timer = 0;
		  }
	  }
    }
    else {
		global.state = global.state_match; //move to the matching state
	}
    break;//break out of the switch statement. nothing under here will run
  case global.state_match://if we're in the matching state
	if(global.ai_selected == noone){
		//random AI card 
		global.ai_selected = ds_list_find_value(global.hand_ai,irandom_range(0,ds_list_size(global.hand_ai)-1));
		global.ai_choice = global.ai_selected.face_index;
		
	}else{
		check_timer++;
		if(check_timer == global.game_speed*3){
			audio_play_sound(snd_flip,1,0);
			global.ai_selected.target_x = room_width/2-32;
			global.ai_selected.target_y = room_height*1/6 + 160;
		}
	}
	
	if (global.selected != noone){
		wait_timer++;
		if(global.selected.face_up && global.selected.side == 1){
			global.player_choice = global.selected.face_index; 
			global.selected.target_y = room_height*5/6 - 160;
			global.selected.target_x = room_width/2-32;
			if(wait_timer == global.game_speed*3-global.game_speed/2){
				global.ai_selected.face_up = true;
			}else if(wait_timer == global.game_speed*3){
				if(global.player_choice != global.ai_choice){
					if((global.player_choice == 0 and global.ai_choice == 1) or (global.player_choice == 1 and global.ai_choice == 2) or (global.player_choice == 2 and global.ai_choice == 0)){
						global.score_player ++;
						audio_play_sound(snd_win,1,0);
					}else if((global.player_choice == 1 and global.ai_choice == 0) or (global.player_choice == 2 and global.ai_choice == 1) or (global.player_choice == 0 and global.ai_choice == 2)){
						global.score_ai ++;
						audio_play_sound(snd_lose,1,0);
					}
				}
			}	
		}
	}
	if(wait_timer>global.game_speed*4){
		check_timer = 0;
		global.state = global.state_clean_up;
		global.ai_selected.face_up = false;
		for(i = 0; i<3;i++){
			var card = ds_list_find_value(global.hand,i);
			card.face_up = false;
		}
		global.selected = noone;
		global.ai_selected = noone;
		wait_timer = 0;
	}
	break;//break out of the switch statement. nothing under here will run
  case global.state_clean_up://if we're in the clean up state
		var cards_in_hand = ds_list_size(global.hand);
		if(cards_in_hand > 0){
			clear_timer ++;
			if(clear_timer>=global.game_speed){
				if(clear_side == 0){
					var return_card = global.hand_ai[| 0]; //get a card
					return_card.targetdepth = -999+last_y_pos;
					audio_play_sound(snd_flip,1,0);
					return_card.face_up = true;
					return_card.target_x = room_width - 100; //set its target position to the discard area
					return_card.target_y = last_y_pos - 2;
					return_card.in_hand = false; //tell the card its not in the hand
					ds_list_add(global.discard, global.hand_ai[| 0]); 
					ds_list_delete(global.hand_ai,0);
					current_card++;
					clear_timer = 0;
					clear_side = 1;
					last_y_pos = return_card.target_y;
				}else{
					var return_card = global.hand[| 0]; //get a card
					return_card.targetdepth = -999+last_y_pos;
					audio_play_sound(snd_flip,1,0);
					return_card.face_up = true;
					return_card.target_x = room_width - 100; //set its target position to the discard area
					return_card.target_y = last_y_pos - 2;
					return_card.in_hand = false; //tell the card its not in the hand
					ds_list_add(global.discard, global.hand[| 0]); 
					ds_list_delete(global.hand,0);
					current_card++;
					clear_timer = 0;
					clear_side = 0;
					last_y_pos = return_card.target_y;
				}
			}
		}else{
			wait_timer++;
			current_card = 0;
			if(wait_timer > global.game_speed*3){ //wait a bit so the player sees what happened
				if(ds_list_size(global.discard) >= 30){ //if we're gone through the whole deck
					rnd = 0;
					global.state = global.state_reshuffle; //go to the shuffle state
					last_y_pos = y+60;
				} else{
					rnd++;
					global.state = global.state_deal;//or go to the deal state again
				}
				wait_timer = 0;
			}
			
		}
		
		
	break;
  case global.state_reshuffle://if we're in the shuffle state
		shuffle_timer++;
		
		if(shuffle_timer >= global.game_speed/4){//wait a bit so the player can see what happened
			//audio
			audio_play_sound(snd_flip,1,0);
			//locate current card
			var newcard = global.discard[|current_card];
			//set its position
			newcard.face_up = false;
			newcard.target_x = x;
			newcard.target_y = y+60-2*current_card;
			newcard.targetdepth = (global.numcards-current_card);
		
			//go back to the deal state
			//wait_timer = 0;
			current_card++;
			shuffle_timer = 0;
		}
		if(current_card == ds_list_size(global.discard)){
			ds_list_clear(global.face_up_cards); //empty the faceup list
			ds_list_shuffle(global.discard);//shuffle the deck
			global.state = global.state_shuffle;
		}
	break;//break out of the switch statement. nothing under here will run
   case global.state_shuffle:
		wait_timer++;
		shuffle_timer++;
		if(ds_list_size(global.discard) != 0){
			for(i = 0; i < ds_list_size(global.discard); i++){//go through the whole discard list
				var return_card = global.discard[| ds_list_size(global.discard)-1];//get a card
				ds_list_delete(global.discard, ds_list_size(global.discard)-1);//remove it from the discard list
				ds_list_add(global.deck, return_card);//add it back to the deck
			}
			//ds_list_shuffle(global.deck);//shuffle the deck
		}
		if(wait_timer >= 20 and shuffle_timer >= global.game_speed/4){//wait a bit so the player can see what happened
			//audio
			audio_play_sound(snd_flip,1,0);
			//locate current card
			var newcard = ds_list_find_value(global.deck,current_card-1);
			//set its position
			newcard.target_x = x;
			newcard.target_y = y+2*current_card;
			newcard.targetdepth = -100-(global.numcards-current_card);
			current_card--;
			shuffle_timer = 0;
		}
		if(current_card == 0){
			global.state = global.state_deal;
			wait_timer = 0;
		}
		
 }
