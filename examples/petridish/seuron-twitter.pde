/*
SOCIAL NEURON visualization
processing+ twitter + jquery 
2012
*/


// 
ArrayList tweets = new ArrayList();
ArrayList seurons = new ArrayList();

PFont font = loadFont("Verdana");	
 
int canvasWidth	= 1150,
	canvasHeight = 600;

float gravity = 0.03;

Seuron daddy;
Seuron friends;
Message m;


// function to add a new Tweet
void addTweet( HashMap data ) {
	Transmitter twi = new Transmitter( "Twitter", color(0, 172, 237) );
	tweets.add( new Message( twi, data ) );

	/*console.log("addTweet: ");
	console.log(data);*/
}

// add a seuron to the global list
void addSeuron( HashMap userdata ) {
	seurons.add( new Seuron( random(20,canvasWidth-50), random(20, canvasHeight-150), 35, 12, 110, userdata ) );
	
	console.log("addSeuron: ");
	console.log(userdata);
}



// ------------------------------- INIT
void setup(){

	size(canvasWidth, canvasHeight);
	background(255);
	//noStroke();
	// colorMode(HSB, 255);//On verra ça plus tard
	frameRate(10);
	smooth();

	//daddy = new Seuron(canvasWidth/2,canvasHeight/2, 75, 12, 110, username);//username est un String c'est pas un HashMap et 110 c'est pas une color
	daddy = new Seuron();
	daddy.r = 75;
	daddy.v = 12;
	daddy.c = color(110);
	daddy.name = username;
}

// ------------------------------- MAIN DRAWING FUNCTION
void draw(){
	////////////////////////////////////////////////////////////////rien à faire dans le draw() -> tout dans le setup()
	size( canvasWidth, canvasHeight );// <<< Le size dans le draw() !!??
	textFont(font, 12);//<<<en double
	textAlign(LEFT);

	//background(30);
	textFont(font, 12);//<<< en double
	////////////////////////////////////////////////////////////////
	var gradient = externals.context.createRadialGradient( width/2, height/2, 0, width/2, height/2, width*0.5); 
	gradient.addColorStop(0,'rgba(80, 80, 80, 1)');
	gradient.addColorStop(1,'rgba(0, 0, 0, 1)'); 
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
	daddy.display();

	
	//draw tweets
	for (int i=0; i<tweets.size(); i++) {
				 
				// daddy.addMessage ( (Tweet) tweets.get(i) );
				
				// ((Tweet) tweets.get(i)).checkService();
				//((Tweet) tweets.get(i)).draw(); //call the draw() of each tweet
				// ((Message) meme.get(i)).display();
				
				//console.log(tweets[i]);
				 //m = new Message( );
	}

	/*
	for (int i=0; i<seurons.size(); i++) {
				Seuron s = (Seuron) seurons.get(i);
				s.display(); //call the draw() of each tweet
	}
	*/

	for (Seuron s : seurons){ // for notation objet
		s.display();
	}

	drawTimeline();
}

void drawTimeline(){
	rectMode(CORNER);
	fill(255,255,0);
	noStroke();
	externals.context.shadowOffsetX = 0;
	externals.context.shadowOffsetY = 0;
	externals.context.shadowBlur = 10;
	externals.context.shadowColor = "black";
	rect(15,height-65,width-30,50,5,5);
	externals.context.restore();

	/*for (Seuron s : seurons){
		float timeX = map(s.date)			
	}*/
}