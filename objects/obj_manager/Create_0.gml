/// @description Insert description here
// You can write your code in this editor

//we have to call randomize to force GM to output randomness every time we run
randomize();

//these are enums
//enums are a constant, user created data type
//we're using enums for our game states
//remember how "magic numbers" are bad? using ints to switch between states is similar
//because enums have names are easier for humans to read

//control of the pace

global.game_speed = 20;






global.score_player = 0;
global.score_ai = 0;

global.player_choice = -1;
global.ai_choice = -1;


global.state_deal = 0;
global.state_reshuffle = 1;
global.state_match = 2;
global.state_clean_up = 3;
global.state_shuffle = 4;

//here we set the game state to the state we want to start with
global.state = global.state_deal;

global.numcards = 30;

//these are lists
//lists are similar to arrays
//the key difference is that we can manipulate lists (dynamically add, remove the contents)
//and that's exactly what we want to do in this game!
global.hand = ds_list_create();
global.hand_ai = ds_list_create();
global.deck = ds_list_create();
global.face_up_cards = ds_list_create();
global.discard = ds_list_create();

rnd = 0;

//here we're actually making our cards
for (i=0; i<global.numcards; i++) {
   var newcard = instance_create_layer(x,y,"Instances",obj_card); //make a card
   newcard.face_index = floor(3*i / global.numcards); //set the card's face

   newcard.face_up = false; //tell the card it is not face up
   newcard.in_hand = false; //tell t he card it is not in the hand
   newcard.side = 0;
   
   ds_list_add(global.deck,newcard); //add the card to the deck list
}


ds_list_shuffle(global.deck);
for (i=0; i<global.numcards; i++) {
	var newcard = ds_list_find_value(global.deck,i);
    //set its position
	newcard.target_x = x;
	newcard.target_y = y+2*i;
	newcard.targetdepth = -(global.numcards-i);
}
wait_timer = 0;
shuffle_timer = 0;
dealt_timer = 0;
dealt_side = 0;
check_timer = 0;
clear_timer = 0;
clear_side = 0;
current_card = 0;
last_y_pos = y+60;
global.selected = noone;
global.ai_selected = noone;
