class Seuron {

	Color couleur;
	int index;
	float cx, cy, radius;
	
	int level; //Daddy:0, Friend&Follow:1 , friend:2, follow3, noName:4

	// float ax, ay; //axon terminal coordinates
	// float e= 2;  // axon excitation : should depend on incoming signals
	// ArrayList<Dendrite> dendrites = new ArrayList(); // store all dendrites inside
	SeuronTmp[] friends;
	SeuronTmp[] followers;
	ArrayList unknowns;
	// ArrayList closeFriends;
	ArrayList<Message> msgs = new ArrayList(); // list of messages


	Seuron( float _x, float _y, float _R, color _C, Object data) {
		// console.log(data);
		couleur = color(_C);
		cx = _x;
		cy = _y; 
		radius = _R; 
		unknowns = new ArrayList;

		splitData(data); //fonction qui assigne les données à des variables de Seuron

	}

	void addFriends(Object data){
		friends=  new SeuronTmp[ data.ids.length ];

		for (int i = 0; i<data.ids.length; i++){
			friends[i]=new SeuronTmp(data.ids[i], 2);
		}

		console.log( "friends : " + friends.length);
	}


	void addFollowers(Object data){
		followers=new SeuronTmp[data.ids.length];

		for (int i = 0; i<data.ids.length; i++){
			followers[i]=new SeuronTmp(data.ids[i], 3);
		}

		console.log("followers : " + followers.length);
	}

	// find if a seuronTmp is friend & follower and give him level 1
	void findCloseFriends() {

		for (int i = 0; i<friends.length; i++){
			if( followers.indexOf(friends[i]) != -1 ) {
				friends[i].level = 1;
				console.log("friend "+ friends[i].id + " is a close friend." );
			}
		}
	}

	void addUnknown(Object data){
		// unknown = new SeuronTmp[data.ids.length];
		unknowns.add( new SeuronTmp(data.id, 4) );

		console.log("unknowns size changed : " + unknowns.size() );
	}

	
	// add a message into list
	void addMessage( Message msg ) {
		// console.log(msg);
		msgs.add( msg );
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


	//////////////////////////////////Méthode pour récupérer les données JSon
	
	String name, screen_name, location, description, url;

	boolean hasAvatar = false;
	PImage avatar;

	String date, timeZone;
	int utc_offset;
	boolean geo_unable;
	
	int id, friends_count, followers_count, statuses_count;
	
	void splitData( Object d ) {

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

	}

	void parseTwitterDate(String twitterDate) {
		var tmp=twitterDate.substr(-4,4) +' . '+ twitterDate.substr(4,15);
		return tmp;
	}

	
}