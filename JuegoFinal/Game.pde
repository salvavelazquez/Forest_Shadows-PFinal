class Game {

  Player player;
  ArrayList<Platform> platforms = new ArrayList<Platform>();
  PImage bgImage;
  PImage platformImage;
  float  camX = -width/2;
  float groundLevel;

  Game() {
    this.groundLevel = height/2.23;

    String playerIdRigth ="Images/Player/rigth/Movimiento/";
    String playerIdLeft ="Images/Player/left/Movimiento/";
    String playerIdReposo="Images/Player/Reposo/";

    String[] playerSpritesRight = {playerIdRigth+"0.png", playerIdRigth+"1.png", playerIdRigth+"2.png", playerIdRigth+"3.png", playerIdRigth+"4.png", playerIdRigth+"5.png"};
    String[] playerSpritesLeft = {playerIdLeft +"0.png", playerIdLeft +"1.png", playerIdLeft +"2.png", playerIdLeft +"3.png", playerIdLeft +"4.png", playerIdLeft +"5.png"};
    String[] playerSpritesReposo={ playerIdReposo+"0.png", playerIdReposo+"1.png", playerIdReposo+"2.png", playerIdReposo+"3.png", playerIdReposo+"4.png", playerIdReposo+"5.png", playerIdReposo+"6.png", playerIdReposo+"7.png", playerIdReposo+"8.png", playerIdReposo+"9.png", playerIdReposo+"10.png", playerIdReposo+"11.png", playerIdReposo+"12.png", playerIdReposo+"13.png", playerIdReposo+"14.png", playerIdReposo+"15.png", playerIdReposo+"16.png", };
    player = new Player(100,  height-200, groundLevel, playerSpritesRight, playerSpritesLeft, playerSpritesReposo, 10);

    bgImage = loadImage("Images/levels/background2.png"); // Carga tu imagen de fondo aquí
    platformImage = loadImage("Images/Ground_11.png"); // Carga tu imagen de plataforma aquí
}

  public void display() {
    background(135, 206, 235); // Un color azul cielo para el fondo

    // Dibujar el fondo repetidamente
    int bgWidth = bgImage.width;
    int bgHeight = -height/2;
    for (int i = -1; i <= width / bgWidth + 1; i++) {
      image(bgImage, i * bgWidth - camX % bgWidth, bgHeight);
    }

    player.update(camX);
    player.handleCollision(platforms);
    // Actualizar la cámara
    camX = max(player.position.x , 0);

   // Dibujar plataformas
    for (Platform p : platforms) {
      p.display(camX, platformImage);
    }

    // Dibujar al jugador
    player.display(camX);
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
