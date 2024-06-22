class Game {

  Player player;
  ArrayList<Platform> platforms = new ArrayList<Platform>();
  

    ArrayList<Enemy> enemies1 = new ArrayList<Enemy>();
  PImage bgImage;
  PImage platformImage;
  float  camX = -width/2;
  float groundLevel;


  Game() {
    this.groundLevel = height/2.23;

    // Directorios de imagenes
    String playerIdRigth ="Images/Player/rigth/Movimiento/";
    String playerIdLeft ="Images/Player/left/Movimiento/";
    String playerIdReposo="Images/Player/Reposo/";
    String enemyRigth ="Images/Enemies/Enemy1/rigth/Movimiento/";
    String enemyIdLeft ="Images/Enemies/Enemy1/left/Movimiento/";

    //Se añaden los sprites del player
    String[] playerSpritesRight = {playerIdRigth+"0.png", playerIdRigth+"1.png", playerIdRigth+"2.png", playerIdRigth+"3.png", playerIdRigth+"4.png", playerIdRigth+"5.png"};
    String[] playerSpritesLeft = {playerIdLeft +"0.png", playerIdLeft +"1.png", playerIdLeft +"2.png", playerIdLeft +"3.png", playerIdLeft +"4.png", playerIdLeft +"5.png"};
    String[] playerSpritesReposo={ playerIdReposo+"0.png", playerIdReposo+"1.png", playerIdReposo+"2.png", playerIdReposo+"3.png", playerIdReposo+"4.png", playerIdReposo+"5.png", playerIdReposo+"6.png", playerIdReposo+"7.png", playerIdReposo+"8.png", playerIdReposo+"9.png", playerIdReposo+"10.png", playerIdReposo+"11.png", playerIdReposo+"12.png", playerIdReposo+"13.png", playerIdReposo+"14.png", playerIdReposo+"15.png", playerIdReposo+"16.png", };
    player = new Player(100, 300, groundLevel, playerSpritesRight, playerSpritesLeft, playerSpritesReposo, 10);

    //Se añaden los sprites de los enemigos

    String[] enemySpritesRight = {enemyRigth+"0.png", enemyRigth+"1.png", enemyRigth+"2.png", enemyRigth+"3.png", enemyRigth+"4.png", enemyRigth+"5.png", enemyRigth+"6.png", enemyRigth+"7.png", enemyRigth+"8.png", enemyRigth+"9.png", enemyRigth+"10.png", enemyRigth+"11.png"};
    String[] enemySpritesLeft = {enemyIdLeft+"0.png", enemyIdLeft+"1.png", enemyIdLeft+"2.png", enemyIdLeft+"3.png", enemyIdLeft+"4.png", enemyIdLeft+"5.png", enemyIdLeft+"6.png", enemyIdLeft+"7.png", enemyIdLeft+"8.png", enemyIdLeft+"9.png", enemyIdLeft+"10.png", enemyIdLeft+"11.png"};




    bgImage = loadImage("Images/levels/background2.png"); // Carga tu imagen de fondo aquí
    platformImage = loadImage("Images/Ground_11.png"); // Carga tu imagen de plataforma aquí

    // Añadir algunas plataformas
    platforms.add(new Platform(-1, groundLevel - 5, 600, 55));
    platforms.add(new Platform(750, groundLevel - 5, 600, 55));
    platforms.add(new Platform(1400, groundLevel - 100, 200, 50));
    // Nuevas plataformas
    platforms.add(new Platform(1600, groundLevel - 200, 150, 50));
    platforms.add(new Platform(1830, groundLevel - 118, 90, 40));
    platforms.add(new Platform(1900, groundLevel - 5, 300, 55));

    platforms.add(new Platform(2400, groundLevel - 5, 300, 55));
    platforms.add(new Platform(2750, groundLevel - 90, 200, 55));
    platforms.add(new Platform(3100, groundLevel - 90, 100, 50));
    platforms.add(new Platform(3250, groundLevel - 5, 1000, 55));

    enemies1.add(new Enemy(300, 230, 4, enemySpritesRight, enemySpritesLeft, 2, 150, 150));
    enemies1.add(new Enemy(width - 250, 230, 6, enemySpritesRight, enemySpritesLeft, 2, 150, 150 ));
  }

  public void display() {
    background(135, 206, 235); // Un color azul cielo para el fondo

    // Dibujar el fondo repetidamente
    //int bgWidth = bgImage.width;
    //int bgHeight = -height/2;
    //for (int i = -1; i <= width / bgWidth + 1; i++) {
    //  image(bgImage, i * bgWidth - camX % bgWidth, bgHeight);
    //}

    player.update(camX);
    player.handleCollision(platforms);
    // Actualizar la cámara
    camX = max(player.position.x, 0);

    // Dibujar plataformas
    for (Platform p : platforms) {
      p.display(camX, platformImage);
    }

    for (Enemy enemy :  enemies1) {
      enemy.update();
      enemy.display(camX);
    }

    // Dibujar al jugador
    player.display(camX);
    
      fill(255);
      textSize(30);
      
      text("Vidas: " + player.lives, -width*0.4, -height*0.4);
  
    
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
