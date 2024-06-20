class Level {
  PImage bgImage;
  ArrayList<Enemy> enemies;

  Level(ArrayList<Enemy> enemies, String bgImage) {
    this.enemies = enemies;
    this.bgImage = loadImage(bgImage);
    this.bgImage.resize(width, height);
  }

  void display() {
    imageMode(CENTER);
    image(bgImage, 0, 0);
   
    for (Enemy enemy : enemies) {
      enemy.update();
      enemy.display();
    }
  }
}
