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
    player = new Player(500, height/2.23, groundLevel);
    bgImage = loadImage("Images/levels/background2.png"); // Carga tu imagen de fondo aquí
    platformImage = loadImage("Images/Ground_11.png"); // Carga tu imagen de plataforma aquí
    // Añadir algunas plataformas
    platforms.add(new Platform(-width/2, groundLevel - 5, 600, 55));
    platforms.add(new Platform(0, groundLevel - 5, 600, 55));
    platforms.add(new Platform(350, groundLevel - 100, 200, 50));
    // Nuevas plataformas
    platforms.add(new Platform(1600, groundLevel - 200, 150, 50));
    platforms.add(new Platform(1830, groundLevel - 118, 90, 40));
    platforms.add(new Platform(1900, groundLevel - 5, 300, 55));
    platforms.add(new Platform(2400, groundLevel - 5, 300, 55));
    platforms.add(new Platform(2750, groundLevel - 90, 200, 55));
    platforms.add(new Platform(3100, groundLevel - 90, 100, 50));
    platforms.add(new Platform(3250, groundLevel - 5, 1000, 55));

    enemies1.add(new Enemy(300, 230, 4));
    enemies1.add(new Enemy(width - 250, 230, 6));
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
