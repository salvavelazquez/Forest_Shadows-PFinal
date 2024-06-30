class Rain{
  float x = random(-width/2,width/2);
  float y = random(-height/2,-600);
  float z = random(0,20);
  float len = map(z, 0, 20, 10, 20);
  float yspeed = map(z, 0, 20, 1, 20);

  public void fall() {
    y = y + yspeed;
    float grav = map(z, 0, 20, 0, 0.2);
    yspeed = yspeed + grav;
    
    if (y > height/2) {
      y = random(-height,-height/3);
      yspeed = map(z, 0, 20, 4, 10);
    }
  }
  
  public void show() {
    float thick = map(z, 0, 20, 1, 3);
    strokeWeight(thick);
    stroke(#5E8AAA);
    line(x,y,x,y+len);
    noStroke();
  }
}
