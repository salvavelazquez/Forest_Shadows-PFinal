class Game {
  ArrayList<Level> levels;
  Player player;
  int currentLevel;

  Game() {

    String playerIdRigth ="Images/Player/rigth/Movimiento/";
    String playerIdLeft ="Images/Player/left/Movimiento/";
    String playerIdReposo="Images/Player/Reposo/";

    String[] playerSpritesRight = {playerIdRigth+"0.png", playerIdRigth+"1.png", playerIdRigth+"2.png", playerIdRigth+"3.png", playerIdRigth+"4.png", playerIdRigth+"5.png"};
    String[] playerSpritesLeft = {playerIdLeft +"0.png", playerIdLeft +"1.png", playerIdLeft +"2.png", playerIdLeft +"3.png", playerIdLeft +"4.png", playerIdLeft +"5.png"};
    String[] playerSpritesReposo={ playerIdReposo+"0.png", playerIdReposo+"1.png", playerIdReposo+"2.png", playerIdReposo+"3.png", playerIdReposo+"4.png", playerIdReposo+"5.png", playerIdReposo+"6.png", playerIdReposo+"7.png", playerIdReposo+"8.png", playerIdReposo+"9.png", playerIdReposo+"10.png", playerIdReposo+"11.png", playerIdReposo+"12.png", playerIdReposo+"13.png", playerIdReposo+"14.png", playerIdReposo+"15.png", playerIdReposo+"16.png", };


    player = new Player(new PVector(-width/3, height/3), playerSpritesRight, playerSpritesLeft, playerSpritesReposo, 10);
    ArrayList<Enemy> enemy = new ArrayList<Enemy>();
    enemy.add(new Enemy(new PVector(width/3, height/3), 2, "Images/Enemies/enemy.png"));

    levels = new ArrayList<Level>();
    levels.add(new Level(enemy, "Images/levels/background1.jpg"));
    currentLevel = 0;
  }

  void display() {
    Level level = levels.get(currentLevel);
    level.display();
    player.display();
    player.update();
  }

  void mouseControladorGame() {
    // manejar el mouse
  }

  void tecladoControladorGame() {
    player.manejarTeclaPresionada();
  }
    void tecladoLiberadoGame() {
    player.manejarTeclaLiberada();
  }
}
