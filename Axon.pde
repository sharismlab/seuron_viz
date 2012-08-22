class Axon {
  Seuron s;

  //constructor
  Axon( Seuron _s ) {
    _s =s;
  }
  
  void draw() {
    fill( 255);
    ellipse(s.cx,s.cy,50,50);
    
    
  }
}

class AxonTerminal {

  Dendrit to;
  Axon from;
  float x, y, e;
  int scount;

  // default values

  //constructor
  AxonTerminal( Axon _from, Dendrit _to ) {
    to = _to;
    from= _from;
    
   // x =  from.cx - cos( radians(360/from.v) )*from.r - random(2);
    // y =  from.cy - sin( radians(360/from.v) )*from.r - random(2);
  }

  void draw() {
    // stroke(from.c, 65);
    strokeWeight(10);
    e=1.5;
    scount=10;
    // println ( dist(from.cx-random(12) + from.r-random(12), from.cy+from.r, to.to.cx, to.to.cy) );
    // line(x+random(10), y+random(10), to.to.cx, to.to.cy);
    scribble( x+random(10), y+random(10), to.to.cx, to.to.cy, scount, e );
    //    ellipse(to.x,to.y,10,10);
  }
}

