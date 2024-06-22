class Game {
  private Player player;
  private ArrayList<Platform> platforms = new ArrayList<Platform>();
  private ArrayList<Enemy> enemies1 = new ArrayList<Enemy>();
  //private PImage bgImage; // BACKGROUND
  private PImage platformImage;
  private float  camX = -width/2;
  private float groundLevel;

  public Game() {
    this.groundLevel = height/2.23;
    this.player = new Player(0, height/2.23, groundLevel);
    //bgImage = loadImage("Images/levels/background2.png"); // Carga tu imagen de fondo aquí
    this.platformImage = loadImage("Images/Ground_11.png"); // Carga tu imagen de plataforma aquí
    /**Seccion donde se crean las plataformas en el constructor por defecto de la clase Game*/
    // ---------- P L A T A F O R M A S ---------//
    platforms.add(new Platform(-width/2, groundLevel +10, 600,55));
    platforms.add(new Platform(0, groundLevel - 5, 600, 55));
    platforms.add(new Platform(1000, groundLevel - 5, 300, 55));
    platforms.add(new Platform(1400, groundLevel - 5, 300, 55));
    platforms.add(new Platform(3100, groundLevel - 90, 100, 50));
    platforms.add(new Platform(3250, groundLevel - 5, 1000, 55));
    // ---------- F L O T A N T E S ---------//
    platforms.add(new Platform(500, groundLevel - 100, 200, 50));
    platforms.add(new Platform(600, groundLevel - 200, 150, 50));
    platforms.add(new Platform(800, groundLevel - 118, 90, 40));
    platforms.add(new Platform(1550, groundLevel - 90, 200, 55));

    enemies1.add(new Enemy(300, height/3, 4));
    //enemies1.add(new Enemy(width - 250, 230, 6));
  }

  public void display() {
    background(0); // Un color azul cielo para el fondo
    player.update();
    player.handleCollision(platforms);
    // Actualizar la cámara
    camX = max(player.position.x, 0);
    // Dibujar plataformas
    for (Platform p : platforms) {
      p.display(camX, platformImage);
    }
    
     
    // Elimina enemigos en el campo de visión del jugador
    player.killEnemiesInView(enemies1);
    for (Enemy enemy : enemies1) {
      enemy.update();
      enemy.display();
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
