class Game {
  private Player player;
  private Rays rays;
  private Boss boss;
  private ArrayList<Platform> platforms = new ArrayList<>();
  private ArrayList<Enemy> enemies1 = new ArrayList<>();
  private PImage platformImage;
  private float camX = -width/2;
  private float groundLevel;

  public Game() {
    this.groundLevel = height/2.23;
    this.player = new Player(0, 0, groundLevel);
    this.rays = new Rays();
    this.boss = new Boss(-width, -height/4, enemies1);
    this.platformImage = loadImage("Images/Ground_11.png");

    // Creación de plataformas
    platforms.add(new Platform(-450, groundLevel + 11, 700, 55));
    platforms.add(new Platform(450, groundLevel + 11, 600, 55));
    platforms.add(new Platform(1600, groundLevel + 11, 300, 55));
    platforms.add(new Platform(2100, groundLevel + 11, 300, 55));
    platforms.add(new Platform(2950, groundLevel + 11, 1000, 55));
    platforms.add(new Platform(5800, groundLevel - 500, 90, 60));
    platforms.add(new Platform(6180, groundLevel - 500, 90, 60));
    platforms.add(new Platform(6300, groundLevel - 350, 90, 60));
    platforms.add(new Platform(6400, groundLevel - 200, 800, 60));
    platforms.add(new Platform(7000, groundLevel + 11, 2000, 55));

    platforms.add(new Platform(1100, groundLevel - 94, 200, 50));
    platforms.add(new Platform(1300, groundLevel - 194, 150, 50));
    platforms.add(new Platform(1530, groundLevel - 112, 90, 40));
    platforms.add(new Platform(2450, groundLevel - 84, 200, 55));
    platforms.add(new Platform(2800, groundLevel - 84, 100, 50));

    platforms.add(new PlatformEnMovimiento(4000, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new PlatformEnMovimiento(4450, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new PlatformEnMovimiento(4950, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new PlatformEnMovimiento(5400, groundLevel - 300, 150, 50, 0.03, true));
  }

  public void display() {
    background(0);
    rays.display();
    boss.display();

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

    // Eliminar enemigos en el campo de visión del jugador
    player.killEnemiesInView(enemies1);

    // Dibujar al jugador
    player.display();
    for (Enemy enemy : enemies1) {
      enemy.update();
      enemy.display(camX);
      

      
    }
    
 

    // Mostrar información adicional (por ejemplo, vidas)
    fill(255);
    textSize(30);
    text("Vidas: " + player.lives, -width * 0.4, -height * 0.4);
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
