/*
SOCIAL NEURON visualization
processing + twitter + jquery 
2012
*/
var cnvs, ctx;

PFont font;

// A global array to store all seurons, including unactive
var seurons = [];

// A simple array storing only ids for all seurons
var seuronIds = [];

// Array to store all ids that needs to be looked up through twitter API
var toLookup = [];

// all our messages + Ids
var messageIds = [];
var messages = [];

// store all our messages
var threads = [];

// messages to be looked up
var messagesLookup = [];

// THE Only boss of all.
Seuron daddy;

// to dispaly messages
boolean showInteraction = false;
boolean displaySeuron = false; // just turn this on to show seuron


// ------------------------------- INIT
void setup(){
	size(screenWidth, screenHeight);
	cnvs = externals.canvas;
	ctx = externals.context;

	// DRAW BACKGROUND
	var gradient = ctx.createRadialGradient( width/2, height/2, 0, width/2, height/2, width*0.5); 
	gradient.addColorStop(0,'rgba(80, 80, 80, 1)');
	gradient.addColorStop(1,'rgba(10, 10, 10, 1)'); 
	ctx.fillStyle = gradient; 
	ctx.fillRect( 0, 0, width, height );

	// console.log(PFont.list());
	font = loadFont("sans-serif");
	textFont(font,48);
	textAlign(CENTER);
	text("LOADING DATA", width/2,height/2);

	textFont(font, 12);


	frameRate(10);
	smooth();

	// for the caption
	colors = [ color(255, 255, 255), color(255, 0, 255), color(255, 255, 0), color(0, 255, 255)];
	captions = [
		"Friend & Follow", 
		"Following", 
		"Follower",
		"Unrelated"
		];
	

	// FRIENDS & FOLLOWERS 
	// ------------------------------
	// they are empty seurons just storing existing relationships
	// they won't be displayed on the screen
	// we will be get their profile data only if they interact with daddy	

	// create daddy 
	Object daddyData = getProfile("makio135");
	daddy = new Seuron( daddyData.id, daddyData, true );
	daddy.cx = width/2;
	daddy.cy = height/2;
	seurons.push(daddy);
	seuronIds.push(daddy.id);

	// console.log(daddy);

	// FRIENDS & FOLLOWERS 
	// create daddy's friends 	
	Object daddyFriends = getFriends("makio135");	
	daddy.friends = daddyFriends.ids;

	// create daddy's followers
	Object daddyFollowers = getFollowers("makio135");
	daddy.followers = daddyFollowers.ids;
	// console.log(daddy.followers);

	// console.log("------- before loop into messages --------");
	// console.log( "created seurons : " + seurons.length );
	// console.log( "daddy's close Friends : " + daddy.getCloseFriends().length );
	// console.log( "daddy's Friends : " + daddy.getFriends().length );
	// console.log( "daddy's Followers : " + daddy.getFollowers().length );
	// console.log( "daddy's Unrelated : " + daddy.getUnrelated().length );

	// console.log("------- analyze timeline --------");

	// THE TIMELINE
	// ------------------------------------------
	// Now let's check the timeline 
	// To extract messages and quoted people from it
	// we should also extract statuses/mentions to have the whole conversation !

	Object daddyTimeline = getTimeline( "makio135" );
	analyzeTimeline( daddyTimeline );
	
	// console.log(daddy.synapses);

	// console.log("------- after loop into messages --------");
	// console.log( "created seurons : " + seurons.length );


	// console.log( "daddy's close Friends : " + daddy.getCloseFriends().length );
	// console.log( "daddy's Friends : " + daddy.getFriends().length );
	// console.log( "daddy's Followers : " + daddy.getFollowers().length );
	// console.log( "daddy's Unrelated : " + daddy.getUnrelated().length );

	// // console.log(daddy);

	// console.log( "total of seurons created :" + seurons.length );
	// console.log("total number of messages :" + messages.length);
	// console.log( "total of active seurons :" + activeSeurons.length );
	// // console.log( activeSeurons );

	// console.log( "total number of daddy synapses : " + daddy.synapses.length);

}

// ------------------------------- MAIN DRAWING FUNCTION
void draw(){
	// DRAW BACKGROUND
	var gradient = ctx.createRadialGradient( width/2, height/2, 0, width/2, height/2, width*0.5); 
	gradient.addColorStop(0,'rgba(180, 180, 180, 1)');
	gradient.addColorStop(1,'rgba(150, 150, 150, 1)'); 
	ctx.fillStyle = gradient; 
	ctx.fillRect( 0, 0, width, height ); 

	// DRAW TIMELINE
	drawTimeline();

	// draw caption
	textAlign(LEFT);
	 fill(255);
	 text("Press Mouse Button To Show Messages", 15,height-90);
	 textAlign(RIGHT);
	 text("Caption".toUpperCase(), width-15,25);
	 for (int i = 0; colors[i]; i++){
	 	fill(colors[i]);
	 	text(captions[i], width-15, i*15+45);
	 }

	// draw daddy
	daddy.display();

	// DISPLAY OUR GUYS
	if( displaySeuron == true) displayAllSeurons();

}


void displayAllSeurons(){
	for(int i=1; i<5; i++){
		stroke(0,150);
		noFill();
		ellipse(width/2,height/2,75+i*150,75+i*150);
	}

	//draw messages
	if( showInteraction ) {
		for (int i = 0; interactions[i]; i++){
			interactions[i].display();
		 }
	}

	if(mousePressed) {
		showInteraction = true;
	} else {
		showInteraction = false;
	}


	var close = [];
	var myfriends = [];
	var myfollowers = [];
	var unknown = [];

	// drawSeurons
	myfriends = daddy.getFriends();
	myfollowers = daddy.getFollowers();
	close  = daddy.getCloseFriends();
	unknown = daddy.getUnrelated();

	float cx = screenWidth/2;
	float cy = screenHeight/2;

	// draw close friends
	for (int i = 0; close[i]; i++){

		// console.log(friends[i]);

		float r = 75;

		float angle = i * TWO_PI / close.length;

  		float x = cx + cos(angle) * r;
  		float y = cy + sin(angle) * r;
			
		close[i].cy = y;
		close[i].cx = x;

		close[i].couleur= colors[0];

		close[i].display();
	} 

	// draw friends
	for (int i = 0; myfriends[i]; i++){

		// console.log(friends[i]);

		float r = 150;

		float angle = i * TWO_PI / myfriends.length;

  		float x = cx + cos(angle) * r;
  		float y = cy + sin(angle) * r;
			
		myfriends[i].cy = y;
		myfriends[i].cx = x;
		
		myfriends[i].couleur = colors[1];

		myfriends[i].display();
	} 
	
	// draw followers
	for (int i = 0; myfollowers[i]; i++){

		// console.log(friends[i]);

		float r = 225;

		float angle = i * TWO_PI / myfollowers.length;

  		float x = cx + cos(angle) * r;
  		float y = cy + sin(angle) * r;
			
		myfollowers[i].cy = y;
		myfollowers[i].cx = x;
		myfollowers[i].couleur = colors[2];

		myfollowers[i].display();
	} 

	// draw unknown
	for (int i = 0; unknown[i]; i++){

		float r = 300;

		float angle = i * TWO_PI / unknown.length;

  		float x = cx + cos(angle) * r;
  		float y = cy + sin(angle) * r;
			
		unknown[i].cy = y;
		unknown[i].cx = x;
		unknown[i].couleur = colors[3];
		unknown[i].display();
	}

	for (int i= 1; seurons[i]; i++){
		if(seurons[i].isSelected) seurons[i].showInfoBox();
	}
}


// ------------------------------- LOOKUP LOCAL DATA
void lookupUsers() {
	// parse twitter url
	
	String url = "https://api.twitter.com/1/users/lookup.json?include_entities=true";
	url += "&user_id=";
	for (int i = 0; i<toLookup.length-1; i++){
		url += toLookup[i] + ",";
	}
	url += toLookup[ toLookup.length-1 ];

	// console.log( url );

	// console.log("looking for users : " + toLookup.length);

	// console.log(toLookup);
	var aaa;
	if(toLookup.length == 100 ){
		url="datasamples/clemsos_lookup_A.json";
	} else {
		url="datasamples/clemsos_lookup_B.json";
		aaa  =1 ;
	}
	
	// url = "datasamples/makio135_lookup_actives.json"

	$.getJSON(url, function(data) {
		// console.log("JSON LOOKUP : got " + data.length + " users profiles")
		$.each( data, function(key, item) {
			//populate seurons with twitter data
			parseUser( item );
		});
		displaySeuron = true;

		
		if( aaa ==1 ) {
			// console.log("------ go go go, VIZ !");
			displaySeuron = true; 
			
			// checkData();
		}
		
	});
}


int dateMin = (new Date()).getTime(); // Return the number of milliseconds since 1970/01/01:
int dateMax = 0;
int seconds;
float descHeight;
float TimelinePosX=0, TimelinePosY=0;
void drawTimeline(){
	////////////////////////DRAW TIMELINE ELEMENTS
		ctx.save();
		rectMode(CORNER);
		fill(100);
		noStroke();
		ctx.shadowOffsetX = 0;
		ctx.shadowOffsetY = 0;
		ctx.shadowBlur = 10;
		ctx.shadowColor = "black";
		rect(15,height-75,width-30,60);

		fill(0,80);
		rect(15,height-75,20,60);
		ctx.restore();
		pushMatrix();
		translate(29,height-45);
		rotate(-Math.PI/2);
		fill(255);
		textAlign(CENTER);
		text("Timeline",0,0);
		popMatrix();


	////////////////////////DRAW SEURONS
	for (int i= 1; seurons[i]; i++){
		Seuron s = seurons[i];

		if(seurons[i].hasAvatar ==true) {
			// console.log(s);

			seconds = Date.parse(seurons[i].date);
			if(seconds<dateMin){
				dateMin = seconds;
				// println("dateMin: " + dateMin);
			}
			else if(seconds>dateMax){ 
				dateMax = seconds;
				// println("dateMax: " + dateMax);
			}

			TimelinePosX = map(seconds,dateMin,dateMax,45,width-25);
			TimelinePosY = height-75 + map(seurons[i].cy,100,screenHeight-150,5,55);
			stroke(seurons[i].couleur);
			strokeWeight(2);
			strokeCap(SQUARE);
			line(TimelinePosX, height-75, TimelinePosX, height-16);
			fill(seurons[i].couleur);
			ellipse(TimelinePosX,TimelinePosY,8,8);

			if(dist(mouseX, mouseY, TimelinePosX, TimelinePosY)<8 || dist(mouseX, mouseY, seurons[i].cx, s.cy)<seurons[i].radius/2) {
				line(TimelinePosX, TimelinePosY, seurons[i].cx, seurons[i].cy);

				seurons[i].isSelected = true;
			}
			else{
				seurons[i].isSelected=false;
			}
		}
	}
}