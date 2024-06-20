class Game {
  ArrayList<Level> levels;
  Player player;
  int currentLevel;
  
  Game() {
    
      player = new Player(new PVector(-width/3,height/3), "Images/player.png");
      ArrayList<Enemy> enemy = new ArrayList<Enemy>();
      enemy.add(new Enemy(new PVector(width/3,height/3), 2,"Images/Enemies/enemy.png"));
    
      levels = new ArrayList<Level>();
      levels.add(new Level(enemy, "Images/levels/background1.jpg"));
      currentLevel = 0;
  }
  
  void display() {
      Level level = levels.get(currentLevel);
      level.display();
      player.display();
  }
  
  void mouseControladorGame() {
    // manejar el mouse
  }

  void tecladoControladorGame() {
    player.update();
  }
}
