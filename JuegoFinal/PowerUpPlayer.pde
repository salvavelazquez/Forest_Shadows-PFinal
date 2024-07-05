class PowerUpPlayer extends GameObject{
  private PImage image;
  
  public PowerUpPlayer(float x, float y, PImage img) {
    this.position = new PVector(x, y);
    this.image = img;
  }
  
  public void display(float camX) {
    image(this.image, this.position.x - camX, this.position.y,50,50);
  }
}
