class Game {
  private Player player;
  private Rays rays;
  private Boss boss;
  private ArrayList<Platform> platforms = new ArrayList<Platform>();
  private ArrayList<Enemy> enemies1 = new ArrayList<Enemy>();
  //private PImage bgImage; // BACKGROUND
  private PImage platformImage;
  private float  camX = -width/2;
  private float groundLevel;

  public Game() {
    this.groundLevel = height/2.23;
    this.player = new Player(0, height/2.23, groundLevel);
    this.rays = new Rays();
    this.boss = new Boss(-width,-height/4);
    //bgImage = loadImage("Images/levels/background2.png"); // Carga tu imagen de fondo aquí
    this.platformImage = loadImage("Images/Ground_11.png"); // Carga tu imagen de plataforma aquí
    /**Seccion donde se crean las plataformas en el constructor por defecto de la clase Game*/
    // ---------------- P L A T A F O R M A S  -----------------//
    platforms.add(new Platform(-450, groundLevel +11, 700, 55));
    platforms.add(new Platform(450, groundLevel + 11, 600, 55));
    platforms.add(new Platform(1600, groundLevel + 11, 300, 55));
    platforms.add(new Platform(2100, groundLevel + 11, 300, 55));
    platforms.add(new Platform(2950, groundLevel + 11, 1000, 55));
    platforms.add(new Platform(5800, groundLevel-500, 90, 60));
    platforms.add(new Platform(6180, groundLevel-500, 90, 60));
    platforms.add(new Platform(6300, groundLevel-350, 90, 60));
    platforms.add(new Platform(6400, groundLevel-200, 800, 60));
    platforms.add(new Platform(7000, groundLevel+11, 2000, 55));
    
    
    // ----------------- F L O T A N T E S --------------------//
    platforms.add(new Platform(1100, groundLevel - 94, 200, 50));
    platforms.add(new Platform(1300, groundLevel - 194, 150, 50));
    platforms.add(new Platform(1530, groundLevel - 112, 90, 40));
    platforms.add(new Platform(2450, groundLevel - 84, 200, 55));
    platforms.add(new Platform(2800, groundLevel - 84, 100, 50));
    
    
    // ----------------------- F L O T A N T E S en MOVIMIENTO -------------------------//
    platforms.add(new PlatformEnMovimiento(4000, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new PlatformEnMovimiento(4450, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new PlatformEnMovimiento(4950, groundLevel - 94, 150, 50, 0.03, false));
    platforms.add(new PlatformEnMovimiento(5400, groundLevel - 300, 150, 50, 0.03, true));

    enemies1.add(new Enemy(300, height/3, 4,400));
    enemies1.add(new Enemy(900, height/3, 4,400));
  }

  public void display() {
    background(0);
    rays.display();
    boss.display();
    boss.moveSinCos();
    boss.move();
    player.update();
    player.handleCollision(platforms);
    // Actualizar la cámara
    camX = max(player.position.x, 0);
    // Dibujar plataformas
    for (Platform p : platforms) {
      if(p instanceof PlatformEnMovimiento ){
        ((PlatformEnMovimiento)p).update();
      }
      p.display(camX, platformImage);
    }
    
     
    // Elimina enemigos en el campo de visión del jugador
    player.killEnemiesInView(enemies1);
    for (Enemy enemy : enemies1) {
      enemy.update();
      enemy.display(camX);
    }
    // Dibujar al jugador
    player.display();
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
