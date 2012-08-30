/*
SOCIAL NEURON visualization
processing+ twitter + jquery 
2012
*/


// 
// ArrayList tweets = new ArrayList();
ArrayList seurons = new ArrayList();

PFont font = loadFont("Verdana");
 
int canvasWidth	= 1150,
	canvasHeight = 600;

float gravity = 0.03;

Seuron daddy;
Seuron friends;
Message m;


// function to add a new Tweet
void analyzeTweet( HashMap data ) {

	

	// extract seurons
    // data.user_id

    // data.entities

    // check if seuron exists
    
    
    // if doesnt exists? add seuron : break
    
	// seuron.tweets.add( new Message( twitterTransmitter, data ) );

}

// add a seuron to the global list
void addSeuron( HashMap userdata ) {

    // check if seuron exists
    
    
    // if doesnt exists? add seuron : break
	seurons.add( new Seuron( random(20,canvasWidth-50), random(100, canvasHeight-150), 35, color(random(255),random(255),random(255)), userdata ) );
	
	console.log("addSeuron: ");
	console.log(userdata);
}

// ------------------------------- INIT
void setup(){

	size(canvasWidth, canvasHeight);
	background(255);
	textFont(font, 12);

	// colorMode(HSB, 255);//On verra ça plus tard
	frameRate(10);
	smooth();

	//Daddy 
	/*daddy = new Seuron();
	daddy.r = 75;
	daddy.c = color(110);
	daddy.name = username;*/
}

// ------------------------------- MAIN DRAWING FUNCTION
void draw(){

	////////////////////////////////////////////////////////////////
	var gradient = externals.context.createRadialGradient( width/2, height/2, 0, width/2, height/2, width*0.5); 
	gradient.addColorStop(0,'rgba(80, 80, 80, 1)');
	gradient.addColorStop(1,'rgba(10, 10, 10, 1)'); 
	externals.context.fillStyle = gradient; 
	externals.context.fillRect( 0, 0, width, height ); 

	// draw legend
	/*
		fill(twi.c);
		text(twi.name,350, 30);

		fill(gplus.c);
		text(gplus.name,350, 50);
	*/

	// draw main seuron
	// daddy.display();

	
	//draw tweets
	/*
	for (int i=0; i<tweets.size(); i++) {
		 
		// daddy.addMessage ( (Tweet) tweets.get(i) );
		
		// ((Tweet) tweets.get(i)).checkService();
		//((Tweet) tweets.get(i)).draw(); //call the draw() of each tweet
		// ((Message) meme.get(i)).display();
		
		//console.log(tweets[i]);
		 //m = new Message( );
	}
	*/

	drawTimeline();

	for (Seuron s : seurons){ // for notation objet
		s.display();
	}
}


int dateMin = (new Date()).getTime(); // Return the number of milliseconds since 1970/01/01:
int dateMax = 0;
int seconds;
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

	for (Seuron s : seurons){
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
		TimelinePosY = height-75 + map(s.cy,100,canvasHeight-150,5,55);
		stroke(s.couleur);
		strokeWeight(2);
		strokeCap(SQUARE);
		line(TimelinePosX, height-75, TimelinePosX, height-16);
		fill(s.couleur);
		ellipse(TimelinePosX,TimelinePosY,8,8);

		if(dist(mouseX, mouseY, TimelinePosX, TimelinePosY)<8 || dist(mouseX, mouseY, s.cx, s.cy)<s.radius) {
			line(TimelinePosX, TimelinePosY, s.cx, s.cy);
			fill(0,150);
			noStroke();
			rect(15,15,460,65);
			fill(255);
			textAlign(LEFT);
			text("User: "+s.name+"\nDate: "+s.date+"\nDescription: "+s.description,20,20,450,55);
		}
	}
}
