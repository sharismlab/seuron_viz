// An axon terminal is connected to a dendrit
class AxonTerminal {

  Dendrit to;
  Seuron from;
  float x, y, e;
  int scount;

  // default values

  //constructor
  AxonTerminal( Seuron _from, Dendrit _to ) {
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
    scribble( x+random(10), y+random(10), to.to.cx, to.to.cy, scount, e );
  }
}
