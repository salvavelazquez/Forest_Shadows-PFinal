class Game {
  private Player player;
  private Rays rays;
  private Rain[] rain;
  private Boss boss;
  private ArrayList<Platform> platforms = new ArrayList<>();
  private ArrayList<Enemy> inactiveEnemies = new ArrayList<>();
  private ArrayList<PowerUpPlayer> energy = new ArrayList<>();
  private PImage platformImage, portalImage, powerUpImage;
  private float camX = -width/2;
  private float groundLevel;

  //private PImage bgImage;

  public Game() {
    this.groundLevel = height/2.23;
    this.player = new Player(0, 0, groundLevel);
    this.rays = new Rays();
    this.rain = new Rain[100];
    this.boss = new Boss(-width, -height/4, platforms, this);
    this.platformImage = loadImage("Images/Ground_11.png");
    this.portalImage = loadImage("Images/portal.png");
    this.powerUpImage = loadImage("Images/powerup.png");

    for (int i = 0; i < rain.length; i++) {
      rain[i] = new Rain();
    }
    //bgImage = loadImage("Images/levels/background.png"); // Carga tu imagen de fondo aquí
    //bgImage.resize(width, height);

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

    platforms.add(new MobilePlatform(4000, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new MobilePlatform(4450, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new MobilePlatform(4950, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new MobilePlatform(5400, groundLevel - 300, 150, 50, 0.03, true));

    //power-ups
    energy.add(new PowerUpPlayer(450, groundLevel - 50, powerUpImage));
    energy.add(new PowerUpPlayer(1600, groundLevel - 50, powerUpImage));
    energy.add(new PowerUpPlayer(2450, groundLevel - 134, powerUpImage));

    // Crear enemigos inactivos
    for (int i = 0; i < 7; i++) {
      Enemy enemy = new Enemy(0, 0, 200, player);
      inactiveEnemies.add(enemy);
    }
  }

  public void display() {
    background(0);
    for (int i = 0; i < rain.length; i++) {
      rain[i].show();
      rain[i].fall();
    }
    // Dibuja el fondo
    //drawBackground();
    rays.display();
    boss.display(camX);
    boss.move();
    player.update();
    player.handleCollision(platforms);
    player.handleEnemyCollision( getActiveEnemies());

    // Actualizar la cámara
    camX = max(player.position.x, 0);

    // Dibujar plataformas
    for (Platform p : platforms) {
      if (p instanceof MobilePlatform) {
        ((MobilePlatform)p).update();
      }
      p.display(camX, platformImage);
    }

    // Dibujar power-ups
    for (PowerUpPlayer powerUp : energy) {
      powerUp.display(camX);
    }

    //Mostrar Portal
    image(portalImage, 8850 - camX, 278, portalImage.width, portalImage.height);

    // Eliminar enemigos en el campo de visión del jugador
    player.killEnemiesInView(inactiveEnemies);

    // Dibujar al jugador
    player.display();

    //Dibuja el enemigo y los comportamientos del enemigo
    for (Enemy enemy : inactiveEnemies) {
      enemy.update(platforms);
      enemy.display(camX);
    }
    // Mostrar información adicional (por ejemplo, vidas)
    fill(255);
    textSize(30);
    text("Vidas: " + player.lives, -width * 0.4, -height * 0.4);

    // Detectar colisiones con power-ups
    collisionPowerUpPlayer();
    text("PowerUp: " + player.powerUpCount, -width * 0.39, -height * 0.45);
  }

  /**void drawBackground() {
   int bgWidth = bgImage.width;
   int bgHeight = 0;
   for (int i = -1; i <= width / bgWidth + 1; i++) {
   image(bgImage, i * bgWidth - camX % bgWidth, bgHeight);
   }
   }*/



  public void mouseControllerGame() {
    // Controlador de mouse
  }

  public void keyControllerGame() {
    player.handleKeyPressed();
  }

  public void releasedKeyGame() {
    player.handleKeyReleased();
  }

  public ArrayList<Platform> getPlatforms() {
    return platforms;
  }

  public void activateEnemy(PVector newPositionEnemy) {
    for (Enemy enemy : inactiveEnemies) {
      if (enemy.position.x == 0) {
        enemy.activate(newPositionEnemy);
        break;
      }
    }
  }
  private ArrayList<Enemy> getActiveEnemies() {
    ArrayList<Enemy> activeEnemies = new ArrayList<>();
    for (Enemy enemy : inactiveEnemies) {
      if (enemy.isActive()) {
        activeEnemies.add(enemy);
      }
    }
    return activeEnemies;
  }

  private void collisionPowerUpPlayer() {
    for (int i = energy.size() - 1; i >= 0; i--) {
      PowerUpPlayer powerUp = energy.get(i);
      if (player.position.dist(powerUp.position) < 50) {
        energy.remove(i);
        player.addPowerUp();
      }
    }
  }
}
