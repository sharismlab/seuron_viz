class Seuron {

  color c;
  int v;
  int index;
  float cx, cy, r, opac;
  String name;
  float[] vx, vy; // vertex coordinates
  float ax, ay; //axon terminal coordinates
  float e= 2;  // axon excitation : should depend on incoming signals
  ArrayList<Dendrite> dendrites; // store all dendrites inside 



  // default values
  Seuron() {
    c = color(255); // color
    cx = width/2;   // x 
    cy= width/2;    // y
    r= width/4;     // radius
    v= 13;          //number of vertex
    opac=50;        // base opacity
  }

  //constructor
  Seuron( float _x, float _y, float tempR, int tempV, color tempC, String _name ) {

    c = tempC;
    cx = _x;
    cy = _y; 
    r= tempR; 
    v=tempV;
    name= _name;

    // vertex coordinates
    vx = new float[v+2];  // vertex X
    vy = new float[v+2];  // vertex Y

    for (int i=0; i<v+2;i++) {
      vx[i] =  cos( radians(360/v*i ) )*r + random(2)+ cx; //cos(radians(a[i]))*r+ cx;
      vy[i] =  sin( radians(360/v*i ) )*r + random(2)+ cy; //sin(radians(a[i]))*r+ cy;
    }
  }


  void drawNucleus() { 
    // begin drawing nucleus
    stroke(c);
    strokeWeight(1);
    fill(c);
    ellipse(cx,cy,100,100);

    //draw nucleus
    /*beginShape();
    for (int i=0; i<v+2; i++) {
      curveVertex( vx[i] - random(10), vy[i] - random(10) );
      // add center
      point( cx, cy );
    }
    endShape(CLOSE);
    */

    // display name
    fill(0);
    textAlign(CENTER);
    text(name, cx, cy);
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
    ax = cx + r*2;// + random(12);
    ay = cy + r*2;// + random(12);

    stroke(c,75);
    strokeWeight(5);
    line(cx,cy,ax,ay);
    // scribble(cx,cy,ax,ay,5,20);
    
    // axon terminal
    fill(c,75);
    ellipse(ax,ay,20,20);
    
    // println(this);
  }

  void showAvatar() {
    // this function should return display avatar from Twitter
  }

  void display() {
    drawNucleus();
    drawAxon();
  }
}

