class Seuron {

	color couleur;
	int v;
	int index;
	float cx, cy, radius, opac;
	HashMap data;
	String name;
	Boolean hasAvatar = false;

	float[] vx, vy; // vertex coordinates
	float ax, ay; //axon terminal coordinates
	float e= 2;  // axon excitation : should depend on incoming signals
	ArrayList<Dendrite> dendrites = new ArrayList(); // store all dendrites inside
	ArrayList<Message> msgs = new ArrayList(); // list of messages


	// default values
	Seuron() {
		couleur = color(255); // color
		cx = width/2;   // x 
		cy= height/2;   // y
		radius= 50;	 		// radius
		v= 13;		  // number of vertex
		opac=50;		// base opacity
		name="name";	// seuron name
	}

	//constructor
	Seuron( float _x, float _y, float _R, int _V, color _C, HashMap _data) {
		couleur = color(_C);
		cx = _x;
		cy = _y; 
		radius = _R; 
		v = _V;
		data = _data;
		splitData(); //fonction qui assigne les données à des variables de Seuron

		// vertex coordinates
		vx = new float[v+2];  // vertex X
		vy = new float[v+2];  // vertex Y

		for (int i=0; i<v+2;i++) {
			vx[i] =  cos( radians(360/v*i ) )*radius + random(2)+ cx; //cos(radians(a[i]))*radius+ cx;
			vy[i] =  sin( radians(360/v*i ) )*radius + random(2)+ cy; //sin(radians(a[i]))*radius+ cy;
		}
	}

	// add a message into list
	void addMessage( Message msg ) {
		msgs.add( msg );
		// console.log(msg);
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

	void showAvatar() {
		// this function should return display avatar from Twitter
		imageMode(CENTER);
		if(avatar.width>1){
			image(avatar,cx,cy,radius-10,radius-10);
		}
	}

	void display() {
		drawNucleus();
		drawAxon();
	}


	//////////////////////////////////Méthode pour récupérer les données JSon
	String date;
	PImage avatar;
	String timeZone;
	String description;
	void splitData() {
		name = data.name;
		date = parseTwitterDate(data.created_at);
		// println(data.created_at);
		// println(date);
		// println(Date.parse(date));
		avatar = requestImage(data.profile_image_url);
		timeZone = data.time_zone;
		description = data.description;
		if(data.profile_image_url != null) hasAvatar = true;
	}

	void parseTwitterDate(String twitterDate) {
		var tmp=twitterDate.substr(-4,4) +' . '+ twitterDate.substr(4,15);
		return tmp;
	}
}