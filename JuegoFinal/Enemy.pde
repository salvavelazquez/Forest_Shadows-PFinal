class Enemy {
  PVector position;
  PVector velocity;
  PImage enemyImage;

  Enemy(PVector pos, float speed,String image) {
    this.position = pos;
    this.velocity = new PVector(speed, 0);
    this.enemyImage=loadImage(image);
  }

  void update() {
 
  }

  void display() {
    image(enemyImage, position.x, position.y, 50, 50);
  }
}
