/*
	   _____ ____  _____________    __       _   __________  ______  ____  _   __
	  / ___// __ \/ ____/  _/   |  / /      / | / / ____/ / / / __ \/ __ \/ | / /
	  \__ \/ / / / /    / // /| | / /      /  |/ / __/ / / / / /_/ / / / /  |/ / 
	 ___/ / /_/ / /____/ // ___ |/ /___   / /|  / /___/ /_/ / _, _/ /_/ / /|  /  
	/____/\____/\____/___/_/  |_/_____/  /_/ |_/_____/\____/_/ |_|\____/_/ |_/                          
	        _                  ___             __  _           
	 _   __(_)______  ______ _/ (_)___  ____ _/ /_(_)___  ____ 
	| | / / / ___/ / / / __ `/ / /_  / / __ `/ __/ / __ \/ __ \
	| |/ / (__  ) /_/ / /_/ / / / / /_/ /_/ / /_/ / /_/ / / / /
	|___/_/____/\__,_/\__,_/_/_/ /___/\__,_/\__/_/\____/_/ /_/ 
	                                                           
	   ___   ____ ______ 
	  |__ \ / __ <  /__ \
	  __/ // / / / /__/ /
	 / __// /_/ / // __/ 
	/____/\____/_//____/ 
	                     
	processing + twitter + jquery 
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
var interactions = [];
var interactionIds = [];

// store all our messages
var threads = [];

// messages to be looked up
var messagesLookup = [];

// THE Only boss of all.
Seuron daddy;

// to dispaly messages
boolean showInteraction = false;
boolean displaySeuron = false; // just turn this on to show seuron

Object timelineMentions;


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

	loadData();
}