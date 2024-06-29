class Game {
  private Player player;
  private Rays rays;
  private Boss boss;
  private ArrayList<Platform> platforms = new ArrayList<>();
  private ArrayList<Enemy> enemies = new ArrayList<>();
  private PImage platformImage, portalImage;
  private float camX = -width/2;
  private float groundLevel;

  PImage bgImage;
  //private SoundFile ambientSound, lightningSound;

  public Game() {
    this.groundLevel = height/2.23;
    this.player = new Player(0, 0, groundLevel);
    this.rays = new Rays();
    this.boss = new Boss(-width, -height/4, enemies,platforms);
    this.platformImage = loadImage("Images/Ground_11.png");
    this.portalImage = loadImage("Images/portal.png");


    bgImage = loadImage("Images/levels/background.png"); // Carga tu imagen de fondo aquí
    bgImage.resize(width, height);
    //Sound
    /**this.ambientSound = new SoundFile(p, "Sound/ambientSound.mp3");
     this.lightningSound = new SoundFile(p, "Sound/lightningSound.mp3");
     ambientSound.loop();
     lightningSound.loop();*/

    // Creación de plataformas
    platforms.add(new Platform(-450, groundLevel + 13, 700, 55));
    platforms.add(new Platform(450, groundLevel + 13, 600, 55));
    platforms.add(new Platform(1600, groundLevel + 13, 300, 55));
    platforms.add(new Platform(2100, groundLevel + 13, 300, 55));
    platforms.add(new Platform(2950, groundLevel + 13, 1000, 55));
    platforms.add(new Platform(7000, groundLevel + 13, 850, 55));
    platforms.add(new Platform(7850, groundLevel + 13, 850, 55));
    platforms.add(new Platform(8700, groundLevel + 13, 300, 55));

    platforms.add(new Platform(1100, groundLevel - 94, 200, 50));
    platforms.add(new Platform(1300, groundLevel - 194, 150, 50));
    platforms.add(new Platform(1530, groundLevel - 112, 90, 40));
    platforms.add(new Platform(2450, groundLevel - 84, 200, 55));
    platforms.add(new Platform(2800, groundLevel - 84, 100, 50));

    platforms.add(new Platform(5800, groundLevel - 500, 90, 60));
    platforms.add(new Platform(6180, groundLevel - 500, 90, 60));
    platforms.add(new Platform(6300, groundLevel - 350, 90, 60));
    platforms.add(new Platform(6400, groundLevel - 200, 800, 60));

    platforms.add(new PlatformEnMovimiento(4000, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new PlatformEnMovimiento(4450, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new PlatformEnMovimiento(4950, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new PlatformEnMovimiento(5400, groundLevel - 300, 150, 50, 0.03, true));
  }

  public void display() {
    background(0);

    // Dibuja el fondo
    drawBackground();
    rays.display();
    boss.display(camX);
    boss.move();
    player.update();
    player.handleCollision(platforms);

    // Actualizar la cámara
    camX = max(player.position.x, 0);

    // Dibujar plataformas
    for (Platform p : platforms) {
      if (p instanceof PlatformEnMovimiento) {
        ((PlatformEnMovimiento)p).update();
      }
      p.display(camX, platformImage);
    }

    //Mostrar Portal
    image(portalImage, 8850 - camX, 278, portalImage.width, portalImage.height);

    // Eliminar enemigos en el campo de visión del jugador
    player.killEnemiesInView(enemies);

    // Dibujar al jugador
    player.display();
    for (Enemy enemy : enemies) {
      enemy.update(platforms);
      enemy.display(camX);
    }
    // Mostrar información adicional (por ejemplo, vidas)
    fill(255);
    textSize(30);
    text("Vidas: " + player.lives, -width * 0.4, -height * 0.4);
  }

  void drawBackground() {
    int bgWidth = bgImage.width;
    int bgHeight = 0;
    for (int i = -1; i <= width / bgWidth + 1; i++) {
      image(bgImage, i * bgWidth - camX % bgWidth, bgHeight);
    }
  }



  void mouseControladorGame() {
    // Controlador de mouse
  }

  void tecladoControladorGame() {
    player.manejarTeclaPresionada();
  }

  void tecladoLiberadoGame() {
    player.manejarTeclaLiberada();
  }

  public ArrayList<Platform> getPlatforms() {
    return platforms;
  }
}
