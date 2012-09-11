/*
SOCIAL NEURON visualization
processing + twitter + jquery 
2012
*/

PFont font = loadFont("Comic Sans");
 
/*int canvasWidth	= screenWidth,
	canvasHeight = screenHeight;
*/


// set a environment var for local development
// useful for loading local data
var ENV = "dev";


// A global array to store all seurons
var seurons = [];

// A simple array storing only ids for all seurons
var seuronIds = [];

// Array to store all ids that needs to be looked up through twitter API
toLookup = [];

// all our messages Ids
var messageIds = [];

// all our messages 
var messages = [];

// messages to be looked up
var messagesLookup = [];

// THE Only boss of all.
Seuron daddy;

// to dispaly messages
boolean showMessage = false;
boolean displaySeuron = false; // just turn this on to show seuron


// ------------------------------- INIT
void setup(){
	size(screenWidth, screenHeight);
	background(255);
	textFont(font, 12);
	frameRate(10);
	smooth();

	// for the caption
	colors = [ color(255, 255, 255), color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(102, 85, 100) ];
	captions = [
		"Unknown",
		"Friend & Follow", 
		"is Friend of", 
		"is Followed by",
		"No existing relationship"
		];
	

	// FRIENDS & FOLLOWERS 
	// ------------------------------
	// they are empty seurons just storing existing relationships
	// they won't be displayed on the screen
	// we will be get their profile data only if they interact with daddy	

	// create daddy 
	daddyData = getProfile("makio135");
	daddy = createDaddy(daddyData);

	console.log(daddy);

	// FRIENDS & FOLLOWERS 

	// create daddy's friends 	
	daddyFriends = getFriends("makio135");	
	createFriends( daddy, daddyFriends.ids);
	
	// create daddy's followers
	daddyFollowers = getFollowers("makio135");
	createFollowers( daddy, daddyFollowers.ids);


	console.log("------- before loop into messages --------");
	console.log( "created seurons : " + seurons.length );
	console.log( "daddy's close Friends : " + daddy.getCloseFriends().length );
	console.log( "daddy's Friends : " + daddy.getFriends().length );
	console.log( "daddy's Followers : " + daddy.getFollowers().length );
	console.log( "daddy's Unrelated : " + daddy.getUnrelated().length );


	// THE TIMELINE
	// ------------------------------------------
	// Now let's check the timeline 
	// To extract messages and quoted people from it
	// we should also extract statuses/mentions to have the whole conversation !

	daddyTimeline = getTimeline( "makio135" );
	analyzeTimeline( daddyTimeline );
	
	
	// lookupLocalData();

	console.log("------- after loop into messages --------");
	console.log( "created seurons : " + seurons.length );
	console.log( "daddy's close Friends : " + daddy.getCloseFriends().length );
	console.log( "daddy's Friends : " + daddy.getFriends().length );
	console.log( "daddy's Followers : " + daddy.getFollowers().length );
	console.log( "daddy's Unrelated : " + daddy.getUnrelated().length );

	// console.log(daddy);

	console.log( "total of seurons created :" + seurons.length );	
	console.log("total number of messages :" + messages.length);

	var m = 0;
	
	for (int i = 0; i<seurons.length; i++){
		if( s.lookup == false ) m++;
	}

	console.log("------- load data --------");
	console.log("this is local dev example, so load local files");
	
	// for (int i = 0; messages[i]; i++){
		
	// 	// if( messages[i].synapse != 'undefined') 
	// 	// messages[i].display();
	// 	console.log(messages[i].synapse);
	// 	console.log(messages[i].action);

	//  }
}

void getDaddy() {
	for (int i = 0; i<seurons.length; i++){
		if( seurons[i].id == daddy.id ) {
			return seurons[i];
		}
	}
}

// ------------------------------- MAIN DRAWING FUNCTION
void draw(){
	// DRAW BACKGROUND
	var gradient = externals.context.createRadialGradient( width/2, height/2, 0, width/2, height/2, width*0.5); 
	gradient.addColorStop(0,'rgba(80, 80, 80, 1)');
	gradient.addColorStop(1,'rgba(10, 10, 10, 1)'); 
	externals.context.fillStyle = gradient; 
	externals.context.fillRect( 0, 0, width, height ); 

	/*
	// add a loader to screen
	if( loading ) {
		console.log(loading)
		textAlign(CENTER);
		text(isLoading, width/2, height/2);		

	}*/

	// DRAW TIMELINE
	drawTimeline();

	// draw caption
	 color(65);
	 text("PRESS MOUSE BUTTON TO SHOW MESSAGES", screenWidth-300,40);
	 text("Caption", screenWidth-100,60);
	 for (int i = 0; colors[i]; i++){
	 	fill( colors[i] ) ;
	 	text( captions[i], screenWidth-100, i*15+90 ) ;
	 }

	// draw daddy
	daddy.cx =screenHeight/2;
	daddy.cy =screenWidth/2;
	daddy.display();

	// DISPLAY OUR GUYS
	if( displaySeuron == true) display();
}

void display(){

	// drawSeurons
	friends = daddy.getFriends();
	followers = daddy.getFollowers();
	close  = daddy.getCloseFriends();

	unknown = daddy.getUnrelated();

	float cx = screenWidth/2;
	float cy = screenHeight/2;
	
	// hack to fix a strange thing about the other daddy (???) 
	// myDad = getDaddy();

	// draw close friends
	for (int i = 0; close[i]; i++){

		// console.log(friends[i]);

		float r = 100;

		float angle = i * TWO_PI / close.length;

  		float x = cx + cos(angle) * r;
  		float y = cy + sin(angle) * r;
			
		close[i].cy = y;
		close[i].cx = x;

		close[i].couleur= color(255,200,200);

		close[i].display();
	} 

	// draw friends
	for (int i = 0; friends[i]; i++){

		// console.log(friends[i]);

		float r = 200;

		float angle = i * TWO_PI / friends.length;

  		float x = cx + cos(angle) * r;
  		float y = cy + sin(angle) * r;
			
		friends[i].cy = y;
		friends[i].cx = x;
		
		friends[i].couleur = color(127,0,0);

		friends[i].display();
	} 
	
	// draw followers
	for (int i = 0; followers[i]; i++){

		// console.log(friends[i]);

		float r = 250;

		float angle = i * TWO_PI / followers.length;

  		float x = cx + cos(angle) * r*1.5;
  		float y = cy + sin(angle) * r;
			
		followers[i].cy = y;
		followers[i].cx = x;
		followers[i].couleur = color(127,130,0);

		followers[i].display();
	} 

	// draw unknown
	for (int i = 0; unknown[i]; i++){

		float r = 250;

		float angle = i * TWO_PI / unknown.length;

  		float x = cx + cos(angle) * r*3;
  		float y = cy + sin(angle) * r;
			
		unknown[i].cy = y;
		unknown[i].cx = x;

		unknown[i].display();
	}


	// // here comes the dad
	// myDad.cx =screenHeight/2;
	// myDad.cy =screenWidth/2;
	// myDad.display;

	//draw synapses
	/*
	for (int i = 0; daddy.synapses[i]; i++){
		if(daddy.synapses[i].seuronB.data != null)
			daddy.synapses[i].display();
	}
	*/


	//draw messages
	if( showMessage ) {
		for (int i = 0; messages[i]; i++){
			messages[i].display();
		 }
	}

	if(mousePressed) {
		showMessage = true;
	} else {
		showMessage = false;
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

	console.log("looking for users : " + toLookup.length);

	// console.log(toLookup);
	var aaa;
	if(toLookup.length == 100 ){

		url="datasamples/makio135_lookup.json";
	} else {

		url="datasamples/makio135_lookup2.json";
		aaa  =1 ;
	}

	$.getJSON(url, function(data) {
		console.log("JSON LOOKUP : got " + data.length + " users profiles")
		$.each( data, function(key, item) {
			//populate seurons with twitter data
			parseUser( item );
		});
		
		if( aaa ==1 ) {
			console.log("------ go go go, VIZ !");
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
	externals.context.save();
	rectMode(CORNER);
	fill(100);
	noStroke();
	externals.context.shadowOffsetX = 0;
	externals.context.shadowOffsetY = 0;
	externals.context.shadowBlur = 10;
	externals.context.shadowColor = "black";
	rect(15,height-75,width-30,60);

	fill(0,80);
	rect(15,height-75,20,60);
	externals.context.restore();
	pushMatrix();
	translate(29,height-45);
	rotate(-Math.PI/2);
	fill(255);
	text("Timeline",0,0);
	popMatrix();

	for (int i= 1; seurons[i]; i++){
		Seuron s = seurons[i];

		// if(s.hasAvatar ==true) {
			// console.log(s);



			
			seconds = Date.parse(s.date);
			if(seconds<dateMin){
				dateMin = seconds;
				// println("dateMin: " + dateMin);
			}
			else if(seconds>dateMax){ 
				dateMax = seconds;
				// println("dateMax: " + dateMax);
			}

			TimelinePosX = map(seconds,dateMin,dateMax,45,width-25);
			TimelinePosY = height-75 + map(s.cy,100,screenHeight-150,5,55);
			stroke(s.couleur);
			strokeWeight(2);
			strokeCap(SQUARE);
			line(TimelinePosX, height-75, TimelinePosX, height-16);
			fill(s.couleur);
			ellipse(TimelinePosX,TimelinePosY,8,8);

			if(dist(mouseX, mouseY, TimelinePosX, TimelinePosY)<8 || dist(mouseX, mouseY, s.cx, s.cy)<s.radius/2) {
				line(TimelinePosX, TimelinePosY, s.cx, s.cy);
				if(textWidth(s.description)>10) descHeight=1+floor(textWidth("Description: "+s.description)/400);
				else descHeight=0;
				fill(255,255,0,150);
				noStroke();
				rect(15,15,460,33+descHeight*14);
				fill(255);
				textAlign(LEFT);
				text("User: "+s.name+"\nDate: "+s.date+"\nDescription: "+s.description,20,20,400,30+descHeight*14);
			}
		// }
	}
}
