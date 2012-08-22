class Message {

  Seuron to;
  Seuron from;
  Transmitter service;

  boolean running = false;
  float x, y, xx, yy;
  float xpos, ypos;
  float speed = 16.1;

  // constructor
  Message( Seuron _from, Seuron _to, Transmitter _service ) {
    to = _to;
    from = _from;
    service = _service;
    xx = x = from.cx;
    yy = y = from.cy;
  }


  void init() {
    running = true;
    
  }

  void display() {
    
    init();

    if (running) {
      noStroke();
      fill(service.c);
      ellipse(x, y, 15, 15);
    }

    if ( dist(x, y, to.cx-to.r, to.cy-to.r) < 5.0 ) {
      println("end");
      running=false;
    }

    x += (to.cx - x) / speed;
    y += (to.cy - y) / speed;
  }

}

