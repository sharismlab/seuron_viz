// This is some basic example for drawing Social Neuron connections
// by Clement for Sharism Lab http://sharismlab.com
// available at http://studio.sketchpad.cc/v2QirCKHYg

int SEURONS_COUNT = 2;
int dendrites = 15;
int axons = 15;
// Seuron[] seurons = new Seuron[SEURONS_COUNT];
float[] cd, ca;
float rad = 12;
color c = 110;

Seuron s1, s2, s3, s4;
//Synapse syn1, syn2, syn3;
Dendrit d1;
Transmitter twi, gplus;
Message m1, m2, m3, m4;
Axon a1;

Message[] meme = new Message[3];

void setup() {  

  background(0);
  size(400, 400); 
  smooth();
  strokeWeight(2);
  frameRate(10);

  // add transmitters
  twi = new Transmitter( "Twitter", color(0, 172, 237) );
  gplus = new Transmitter( "Google+", color(199, 32, 42) );

  // build seurons
  s1 = new Seuron( 70, 70, 75, 10, c, "isaac");
  s2 = new Seuron( 310, 310, 50, 12, c, "ooof");
  s3 = new Seuron( 80, 270, 25, 10, c, "clemsos");
  //  s4 = new Seuron( 90, 210, 50, 10, c, "jmi");

  //build synapse
//  syn1 = new Synapse(s1, s2);

  // build dendrits
  d1 = new Dendrit(s1, s2, 12.5, 0.5);
  a1 = new Axon(s1);

  // messages
  m1 = new Message( s1, s2, twi );
  m2 = new Message( s2, s3, twi );
  m3 = new Message( s3, s1, twi );
  m4 = new Message( s3, s1, gplus );

  // meme
  meme[0] = m1;
  meme[1] = m2;
  meme[2] = m3;

  /* random seurons
   for (int i=0; i<SEURONS_COUNT; i++) {
   seurons[i]= new Seuron( 110, random(width), random(height), 50, 10, "isaac");
   }*/
  // m2.init();
} 

void draw() {  // this is run repeatedly.  

  background(0);
  s1.display();
  s2.display();
  
  
//  a1.draw();

/*
  m1.display();
*/
// println(dist( m1.x, m1.y, m1.to.cx, m1.to.cy));

  /*if ( dist( m1.x, m1.y, m1.to.cx, m1.to.cy) > m1.to.r) {
    d1.excitate();
  } else {
    d1.inhibate();
  }*/




  /* 
   // build legend
   fill(twi.c);
   text(twi.name,350, 50);
   
   fill(gplus.c);
   text(gplus.name,350, 30);
   
   
   
   // draw seurons
   
   s3.display();
   
   //display messages
   m2.display();
   m4.display();
   
   //draw synapse
   syn1.draw();
   */
}

void mouseClicked() {
  println("clicked");

//  m1.display();

  /*
  for (int i=0; i<meme.length; i++){
   meme[i].running=true;
   meme[i].display();
   meme[i].running=false;
   }
   */
}

