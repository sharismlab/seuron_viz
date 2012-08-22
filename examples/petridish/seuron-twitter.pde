/*
SOCIAL NEURON
example using twitter + jquery for social seurons visualization

*/

// contiene l'elenco dei tweets
ArrayList tweets = new ArrayList();
ArrayList ats = new ArrayList(); 
ArrayList meme = new ArrayList();
PFont font = loadFont("Verdana");  
 
int canvas_x  = 600,
    canvas_y = 400,
    box_w = 10, 
    box_h = 20, 
    col_gap = 1, 
    slot_gap = 3, 
    brick_start = 90, 
    brick_end = 500;

float gravity = 0.03;

Seuron daddy;
Message m;

// ------------------------------- TWEET CLASS
class Tweet{
 
  HashMap tweet;
  int index;
  Slot slot;
  float pos_x, vel_x;
  int slot_index;
  int col_x, frames;
  String[] at;
  Seuron s;
  Transmitter twi = new Transmitter( "Twitter", color(0, 172, 237) );
  
  Tweet(HashMap data, i) { 
    tweet = data;
    at = tweet.entities.user_mentions;
    frames = 0;
    pos_x = brick_start; 
    vel_x = 0;
    if( tweet.entities.user_mentions.length() ) {
        for(int i=0; i<at.length(); i++) {
            atname = tweet.entities.user_mentions[i].screen_name
            s = new Seuron(random(500),random(300), 20, 6, 110, atname);
            ats.add( s );
            m = new Message( daddy,s,twi );
            meme.add( m );
        }
    }
    // console.log
    index = i;
  }

}


// function to add a new Tweet
void addTweet(HashMap tweet) { 
  tweets.add(new Tweet(tweet,tweets.size()));
}


// ------------------------------- INIT
void setup(){
  size(600, 400);
  background(0);
  //noStroke();     
  colorMode(HSB, 255);
  frameRate(10);
  smooth();
  
  daddy = new Seuron(canvas_x/2,canvas_y/2, 75, 12, 110,username);
  
  // add transmitters
  //twi = new Transmitter( "Twitter", color(0, 172, 237) );
  //gplus = new Transmitter( "Google+", color(199, 32, 42) );
  
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
        //((Tweet) tweets.get(i)).draw(); //call the draw() of each tweet
        ((Message) meme.get(i)).display();
        
        //console.log(tweets[i]);
         //m = new Message( );
  }
  
  for (int i=0; i<ats.size(); i++) {
        ((Seuron) ats.get(i)).display(); //call the draw() of each tweet
  }
  
}
