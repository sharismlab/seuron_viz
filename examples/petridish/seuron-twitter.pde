/*
SOCIAL NEURON visualization
processing+ twitter + jquery 
2012
*/


// 
ArrayList tweets = new ArrayList();
ArrayList seurons = new ArrayList();

PFont font = loadFont("Verdana");  
 
int canvas_x  = 600,
    canvas_y = 400;

float gravity = 0.03;

Seuron daddy;
Seuron friends;
Message m;


// function to add a new Tweet
void addTweet( HashMap data ) {
  Transmitter twi = new Transmitter( "Twitter", color(0, 172, 237) );
  tweets.add( new Message( twi, data ) );
}

// add a seuron to the global list
void addSeuron( HashMap userdata ) {
  seurons.add( new Seuron( random(canvas_x), random(canvas_y), 35, 12, 110, userdata ) );
}



// ------------------------------- INIT
void setup(){

  size(600, 400);
  background(0);
  //noStroke();     
  colorMode(HSB, 255);
  frameRate(10);
  smooth();

  daddy = new Seuron(canvas_x/2,canvas_y/2, 75, 12, 110, username);

}

// ------------------------------- MAIN DRAWING FUNCTION
void draw(){

  size( canvas_x, canvas_y );
  textFont(font, 12);
  textAlign(LEFT);

  background(0);
  textFont(font, 12);

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

  for (int i=0; i<seurons.size(); i++) {
        
        ((Seuron) seurons.get(i)).display(); //call the draw() of each tweet

  }
  
}
