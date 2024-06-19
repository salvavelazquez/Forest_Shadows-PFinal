class Player {
  PVector position;
  PVector velocity;
  PImage playerImage;

  Player(PVector pos, String img) {
    position = pos;
    velocity = new PVector(0, 0);
    playerImage = loadImage(img);
  }


  void update() {
    // Movimiento horizontal
    if (keyPressed) {
      if (key == 'a' || key == 'A') {
        velocity.x = -5;
      } else if (key == 'd' || key == 'D') {
        velocity.x = 5;
      }
    } else {
      velocity.x = 0;
    }

    position.add(velocity);
  }

  void display() {
    image(playerImage, position.x, position.y, 50, 50);
  }
}
