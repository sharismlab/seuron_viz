/*
This is the seuron class
A Seuron intends to store info about a specific user from different social networks.

All relationships are stored in an Array of Synapses that connects it to other seurons.

*/

class Seuron {
	
	////////////////////////VARIABLES
		int id;
		boolean lookedUp = false ; // by default, Seuron should be looked up
		Object data;

		// ArrayList<Message> msgs = new ArrayList(); // list of messages

		// store all ids from twitter
		var friends= [];
		var followers = [];

		// here are stored all objects describing relationships
		var synapses = []; 

		// drawings var
		color couleur;
		int index;
		float cx, cy, radius;
		float TimelinePosX=0, TimelinePosY=0;
		boolean isSelected = false;


	////////////////////////CONSTRUCTORS
		// ghost constructor
		Seuron( int _id, Object _data, boolean _lookup  ){

			id =_id;  // id from twitter

			if ( _data != null ) data = _data; // add data from twitter 

			lookedUp = _lookup;

			//fonction qui assigne les données à des variables de Seuron
			if( data != null ) splitData(data); 

			// default vars for display
			cx = 100;
			cy = 100;
			// cx=random(screenWidth);
			// cy=random(100, 350);
			radius=35;
			couleur=color(255,0,0);
		}
		// constructor for drawing purposes
		Seuron( float _x, float _y, float _R, color _C, Object data) {
			// console.log(data);
			couleur = color(_C);
			cx = _x;
			cy = _y; 
			radius = _R; 
			//unknowns = new ArrayList();
			// msgs = new ArrayList();

			splitData(data); //fonction qui assigne les données à des variables de Seuron
		}


	////////////////////////LOGIC FUNCTIONS
		// create a synapse between this seuron and the Seuron passed, adding to friendship level
		// add the created synapse into this seuron synapses list
		void createSynapse( Seuron s ) {
			
			int level;
			
			if ( isFriend( s.id )  && isFollower( s.id )  ) level = 1;
			else if ( isFriend( s.id )   ) level = 2;
			else if( isFollower( s.id )   ) level = 3;
			else level = 4;

			Synapse syn;
			syn = new Synapse( this, s, level );
			
			synapses.push(syn);
		}
	 

		// check if a seuron is a friend of mine
		boolean isFriend( int _id ) {
			for (int i = 0; friends[i]; i++){
				// check if seurons is my friend  
				if( friends[i] == _id ) {
					return true;
				}
			}
			return false;
		}
		// check if a seuron is one of my followers
		boolean isFollower( int _id ) {
			for (int i = 0; followers[i]; i++){
				// check if seurons is my follower 
				if( followers[i] == _id ) {
					return true;
				}
			}
			return false;
		}


		void addFriend( Seuron friend ) {

			// check if he is a follower
			// if ( isCloseFriend( friend ) ) createSynapse(friend, 1);
			if ( isFriend( friend ) && isFollower( friend ) ) createSynapse(friend, 1);
			else createSynapse(friend, 2);		
		}
		void addFollower( Seuron follower ) {
			// check if he is a follower
			// console.log(follower);
			if ( isCloseFriend( follower ) ) createSynapse(follower, 1);

			else createSynapse(follower, 3);
		}

		
		//Return Seuron[] 
		void getCloseFriends() {
			_closeFriends = [];
			for (int i = 0; synapses[i]; i++){
				if (synapses[i].level == 1){
					_closeFriends.push( synapses[i].seuronB );
				}
			}
			return _closeFriends;
		}
		void getFriends() {
			_friends = [];
			for (int i = 0; synapses[i]; i++){
				if (synapses[i].level == 2){
					_friends.push( synapses[i].seuronB );
				}
			}
			return _friends;
		}
		void getFollowers() {
			_followers = [];
			for (int i = 0; synapses[i]; i++){
				if (synapses[i].level == 3){
					_followers.push( synapses[i].seuronB );
				}
			}
			return _followers;
		}
		void getUnrelated() {
			_unrelated = [];
			for (int i = 0; synapses[i]; i++){
				if (synapses[i].level == 4){
					_unrelated.push( synapses[i].seuronB );
				}
			}
			return _unrelated;
		}


		// return Synapse index based on another Seuron id
		void getSynapse( int id ) {
			for (int i = 0; synapses[i]; i++){
				if(synapses[i].seuronB.id == id) return i;
			};
			return null;
		}


		// add data to seuron, then convert and store it
		void populate( Object _data ) {
			data = _data;
			// console.log ( data );
			splitData( data );
		}


		//////////////////////// Méthode pour récupérer les données JSon
		String name, screen_name, location, description, url;

		boolean hasAvatar = false;
		PImage PImgAvatar;
		var avatar = new Image();

		String date, timeZone;
		int utc_offset;
		boolean geo_unable;
		
		int id, friends_count, followers_count, statuses_count;
		
		void splitData( Object d ) {

			// console.log ( d.id );

			id = d.id;
			name = d.name;
			screen_name = d.screen_name;
			location = d.location;
			description = d.description;
			url = d.url;

			if(d.profile_image_url != null){
				hasAvatar = true;
				PImgAvatar = requestImage(d.profile_image_url);
				avatar.src=d.profile_image_url;
			}
			

			date = parseTwitterDate(d.created_at);
			utc_offset = d.utc_offset;
			timeZone = d.time_zone;

			followers_count = d.followers_count;
			friends_count = d.friends_count;
			statuses_count = d.statuses_count;

			geo_unable = d.geo_unable;

			lookedUp = true; 
		}

		void parseTwitterDate(String twitterDate) {
			var tmp=twitterDate.substr(-4,4) +' . '+ twitterDate.substr(4,15);
			return tmp;
		}


	////////////////////////DRAW FUNCTIONS
		void display() {
			// begin drawing nucleus
			stroke(couleur);
			strokeWeight(1);
			fill(couleur,100);
			//draw nucleus
			ellipse(cx,cy,radius,radius);


			if(isSelected){
				showInfoBox();

				// display name
				rectMode(CENTER);
				fill(0,80);
				noStroke();
				rect(cx,hasAvatar?cy+radius-4:cy-4,textWidth(name)+10, 16);
				fill(255);
				textAlign(CENTER);
				text(name, cx, hasAvatar?cy+radius:cy);
			}
		}

		void showInfoBox(){
			if(hasAvatar) showAvatar();

		}

		void showAvatar() {
			// this function should return display avatar from Twitter
			imageMode(CENTER);
			if(avatar.width>1){
				ctx.drawImage(avatar,cx,cy,radius-10,radius-10);
			}
		}
}