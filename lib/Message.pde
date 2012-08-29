class Message {

  Seuron from;
  ArrayList to;
  Transmitter service;
  HashMap data;

  boolean running = false;
  float x, y, xx, yy;
  float xpos, ypos;
  float speed = 16.1;

  // constructor
  Message( Transmitter _service, HashMap _data ) {

    service = _service;
    data = _data;
    
    // extract seuron
    //data.from_user, data.to_user,
    
  }


  void init() {
    running = true;
  }

  void checkService() {
    // Check type of service
    if( service.name.equals("Twitter") ) {
        
        console.log(Seuron);
        
    }

  }



  void display() {
    
    init();

    /*if (running) {
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
    */
  }

}

