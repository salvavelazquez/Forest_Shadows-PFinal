/**Clase del jugador*/
class Player {
  private PVector position;
  private float velocity;
  private PImage playerImage;

  public Player(PVector pos, String img) {
    this.position = pos;
    this.playerImage = loadImage(img);
  }


  void update() {
    velocity = 5;
    // Movimiento horizontal
    if (keyPressed) {
      if (key == 'A' || keyCode == LEFT) {
        this.position.x-=velocity;
      } else if (key == 'D' || keyCode == RIGHT) {
        this.position.x +=velocity;
      }
    } else {
      this.velocity = 0;
    }
  }

  void display() {
    imageMode(CENTER);
    image(this.playerImage, this.position.x, this.position.y, 50, 50);
  }
}
