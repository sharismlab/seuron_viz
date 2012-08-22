
    // dendrites
    /* ra=new float[v];  // radius
    a=new float[v];  //angles
    n=new float[v]; // noise
    for (int i=0; i<v;i++) {
      n[i]=random(50);//noise seed
      ra[i]=random(5, 10);//radius
      a[i]=random(360);//angles
    }*/
    
// draw Dendrites
  /*
  void drawDendrites() {

    fill(c, opac);
    stroke(c);
    r+=.5;

    if (opac>10) opac--;
    for (int i=1; i<v; i++) {

      if (ra[i]>0) {
        n[i]+=.08;
        a[i]+=.5-noise(n[i])*1;

        //  coordinates
        dx = new float[v];  // vertex X
        dy = new float[v];  // vertex Y  

        dx[i] = cos(radians(a[i]))*r+ vx[i];
        dy[i] = sin(radians(a[i]))*r+ vy[i];

        // start drawing
        ellipse(dx[i], dy[i], ra[i], ra[i]);
      }
      ra[i]-=.01;
    }
  }
  */
