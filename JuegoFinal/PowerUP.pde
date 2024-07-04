class PowerUp {
  PVector position;
  PImage image;
  
  PowerUp(float x, float y, PImage img) {
    this.position = new PVector(x, y);
    this.image = img;
  }
  
  void display(float camX) {
    image(this.image, this.position.x - camX, this.position.y,50,50);
  }
}
