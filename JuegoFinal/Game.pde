class Game {
  Player player;
  ArrayList<Platform> platforms = new ArrayList<Platform>();
  PImage bgImage;
  PImage platformImage;
  float camX = 0;
  float groundLevel;

  Game() {
    groundLevel = height - 50;
    player = new Player(100, height - 50, groundLevel);

    bgImage = loadImage("Images/levels/background2.png"); // Carga tu imagen de fondo aquí
    platformImage = loadImage("Images/Ground_11.png"); // Carga tu imagen de plataforma aquí

    // Añadir algunas plataformas
    platforms.add(new Platform(-1, groundLevel - 5 , 600, 55));
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
  }

  void display() {
    background(135, 206, 235); // Un color azul cielo para el fondo

    // Dibujar el fondo repetidamente
    int bgWidth = bgImage.width;
    int bgHeight = bgImage.height;
    for (int i = -1; i <= width / bgWidth + 1; i++) {
      image(bgImage, i * bgWidth - camX % bgWidth, 0);
    }

    player.update(camX);
    player.handleCollision(platforms);

    // Actualizar la cámara
    camX = max(player.position.x - width / 2, 0);

    // Dibujar plataformas
    for (Platform p : platforms) {
      p.display(camX, player.vibrationOffset, platformImage);
    }

    // Dibujar al jugador
    player.display(camX);
  }

  void mouseControladorGame() {
    // manejar el mouse
  }

  void tecladoControladorGame() {
    if (key == 'a' || key == 'A') {
      player.moveLeft();
    }
    if (key == 'd' || key == 'D') {
      player.moveRight();
    }
    if (key == 'w' || key == 'W') {
      player.jump();
    }
  }

  void tecladoLiberadoGame() {
    if (key == 'a' || key == 'A' || key == 'd' || key == 'D') {
      player.stop();
    }
  }
}
