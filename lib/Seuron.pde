/*
This is the seuron class
A Seuron intends to store info about a specific user from different social networks.

All relationships are stored in an Array of Synapses that connects it to other seurons.

*/

class Seuron {
	
	int id;
	boolean lookedUp = false ; // by default, Seuron should be looked up
	Object data;

	// drawings var
	color couleur;
	int index;
	float cx, cy, radius;

	ArrayList<Message> msgs = new ArrayList(); // list of messages

	// store all ids from twitter
	var friends= [];
	var followers = [];

	// here are stored all objects describing relationships
	var synapses = []; 

	// ghost constructor
	Seuron( int _id, Object _data, boolean _lookup  ){

		id =_id;  // id from twitter

		if ( _data != null ) data = _data; // add data from twitter 

		lookedUp = _lookup;

		//fonction qui assigne les données à des variables de Seuron
		if( data != null ) splitData(data); 

		// default vars for display
		cx = random(20,screenWidth-50)
		cy = random(100, screenHeight-150)
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

	// create a synapse between this seuron and the Seuron passed, adding to friendship level
	// add the created synapse into this seuron synapses list
	void createSynapse( Seuron s ) {
		
		int level;
		
		if ( isFriend( s.id )   ) level = 2;
		else if( isFollower( s.id )   ) level = 3;
		else if ( isFriend( s.id )  && isFollower( s.id )  ) level = 1;
		else level = 4;

		if (friends.length == 0 ) console.log( "--------------- --------------------- problem found !!! ");
		if (friends.length == 0 ) console.log(  s.id  );

		// console.log( s.id  + " has a level : " + level );

		Synapse syn;
		syn = new Synapse( this, s, level );
		
		synapses.push(syn);
	}
 
	// check if a seuron is a friend of mine
	boolean isFriend( int id ) {
		for (int i = 0; friends[i]; i++){
			// check if seurons is my friend  
			if( friends[i] == id ) {
				return true;
			}
		}
		return false;
	}

	// check if a seuron is one of my followers
	boolean isFollower( int id ) {
		for (int i = 0; followers[i]; i++){
			// check if seurons is my follower 
			if( followers[i] == id ) {
				return true;
			}
		}
		return false;
	}

	// boolean isUnrelated ( int id ){
	// 	for (int i = 0; synapses[i]; i++){
	// 		// check if seurons is my follower 
	// 		if( synapses[i].seuronB.id != id ) {
	// 			return true;
	// 		}
	// 	}
	// }

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

	// void addUnrelated( Seuron unrelated  ) {
	// 	createSynapse(unrelated, 4);
	// }
	
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

	// return friendship (Synapse) based on an id
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

	
	// add a message into list
	void addMessage( Transmitter trans, Object data, int type ) {
		// console.log(msg);
		msgs.add( new Message(trans, data, type) );
	}


	void drawNucleus() { 
		// begin drawing nucleus
		stroke(couleur);
		strokeWeight(1);
		fill(couleur);
		//draw nucleus
		ellipse(cx,cy,radius,radius);

		if(hasAvatar) showAvatar();

		// display name
		rectMode(CENTER);
		fill(0,80);
		noStroke();
		rect(cx,hasAvatar?cy+radius-4:cy-4,textWidth(name)+10, 16);
		fill(255);
		textAlign(CENTER);
		text(name, cx, hasAvatar?cy+radius:cy);
	}


	// function to store dendrites inside seuron
	/*
		void addDendrites( Dendrit d ) {
			dendrites.add(d);
		}

		void showDendrites() {
			for (int i=0; i< dendrites.size(); i++) {
				( (Dendrit) dendrites.get(i) ).draw();
			}
		}

		void drawAxon() {
			ax = cx + radius*2;// + random(12);
			ay = cy + radius*2;// + random(12);

			stroke(couleur,75);
			strokeWeight(5);
			line(cx,cy,ax,ay);
			// scribble(cx,cy,ax,ay,5,20);
			
			// axon terminal
			fill(couleur,75);
			ellipse(ax,ay,20,20);
			
			// println(this);
		}
	*/

	void showAvatar() {
		// this function should return display avatar from Twitter
		imageMode(CENTER);
		if(avatar.width>1){
			image(avatar,cx,cy,radius-10,radius-10);
		}
	}


	void display() {
		drawNucleus();
		//drawAxon();
	}


	////////////////////////////////// Méthode pour récupérer les données JSon
	
	String name, screen_name, location, description, url;

	boolean hasAvatar = false;
	PImage avatar;

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

		if(d.profile_image_url != null) hasAvatar = true;
		avatar = requestImage(d.profile_image_url);
		 
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

	
}