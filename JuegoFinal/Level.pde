class Level {
  PImage bgImage;
  ArrayList<Enemy> enemies;

  Level(ArrayList<Enemy> enemies, String bgImage) {
    this.enemies = enemies;
    this.bgImage = loadImage(bgImage);
    this.bgImage.resize(1200, 600);
  }

  void display() {
    image(bgImage, 0, 0, width, height);
   
    for (Enemy enemy : enemies) {
      enemy.update();
      enemy.display();
    }
  }
}
