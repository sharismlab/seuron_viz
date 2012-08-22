class Seuron {

  color c;
  int v;
  int index;
  float cx, cy, r, opac;
  String name;
  float[] vx, vy; // vertex coordinates
  //  ArrayList axons;
  Axon a;
  ArrayList dendrites;

  /*  float[] n, ra, a;
   float[] dx, dy; // dendrites coordinates
   */

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
    noFill();
    fill(c);

    //draw nucleus
    beginShape();
    for (int i=0; i<v+2; i++) {
      curveVertex( vx[i] - random(10), vy[i] - random(10) );
      //center
      point( cx, cy );
    }
    endShape(CLOSE);

    // display name
    fill(0);
    text(name, cx-10, cy);
  }


  void addDendrites( Dendrit d ) {
    dendrites.add(d);
  }


  void showDendrites() {
    for (int i=0; i< dendrites.size(); i++) {
      //((Message) meme.get(i)).display();
      ( (Dendrit) dendrites.get(i) ).draw();
    }
  }

  void createAxon() {
    // println(this);
//    a = new Axon(this.parent);
    
  }

  void showAxon() {
   // a.draw();
  }

  void display() {

    // drawDendrites();
    createAxon();
    showAxon();
    drawNucleus();
  }
}

