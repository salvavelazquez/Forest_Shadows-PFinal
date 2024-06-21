class Game {
  private Player player;
  private ArrayList<Platform> platforms = new ArrayList<Platform>();
  private PImage bgImage;
  private PImage platformImage;
  private float camX = -width/2;
  private float groundLevel;

  public Game() {
    this.groundLevel = height/2.23;
    this.player = new Player(100, height/2.23, groundLevel);
    this.bgImage = loadImage("Images/levels/background2.png"); // Carga tu imagen de fondo aquí
    this.platformImage = loadImage("Images/Ground_11.png"); // Carga tu imagen de plataforma aquí

    // Añadir algunas plataformas
    platforms.add(new Platform(-width/2, groundLevel - 5 , 600, 55));
    platforms.add(new Platform(0, groundLevel - 5, 600, 55));
    platforms.add(new Platform(1400, groundLevel - 100, 200, 50));
    // Nuevas plataformas
    platforms.add(new Platform(1600, groundLevel - 200, 150, 50));
    platforms.add(new Platform(1830, groundLevel - 118, 90, 40));
    platforms.add(new Platform(1900, groundLevel - 5, 300, 55));

    platforms.add(new Platform(2400, groundLevel - 5, 300, 55));
    platforms.add(new Platform(2750, groundLevel - 90, 200, 55));
    platforms.add(new Platform(3100, groundLevel - 90, 100, 50));
    platforms.add(new Platform(3250, groundLevel - 5, 1000, 55));
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

  public void mouseControladorGame() {
    // manejar el mouse
  }

  public void tecladoControladorGame() {
    if (keyCode == LEFT) {
      player.moveLeft();
    }
    if (keyCode == RIGHT) {
      player.moveRight();
    }
    if (keyCode == UP) {
      player.jump();
    }
  }

  public void tecladoLiberadoGame() {
    if (keyCode == LEFT||keyCode == RIGHT) {
      player.stop();
    }
  }
}
