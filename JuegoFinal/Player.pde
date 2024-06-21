class Player {

  PVector position;
  PVector speed;
  float gravity = 0.6;
  float jumpPower = -11;
  boolean isJumping = false;
  float groundLevel;
  int playerWidth, playerHeight;

  PImage[] playerRight;
  PImage[] playerLeft;
  PImage[] playerReposo;
  boolean movingLeft;
  boolean movingRight;
  int currentFrame;
  int totalFrames;
  int frameInterval;
  int frameCounter;


  Player(float startX, float startY, float groundLevel, String[] imgsRight, String [] imgsLeft, String [] imgsReposo, int frameInterval ) {
    this.position = new PVector(startX, startY);
    this.speed = new PVector(0, 0);
    this.groundLevel = groundLevel;
    this.playerWidth = 200;
    this.playerHeight =200;

    isJumping = false;
    playerRight = new PImage[imgsRight.length];
    playerLeft = new PImage[imgsLeft.length];
    playerReposo= new PImage[imgsReposo.length];


    for (int i = 0; i < imgsRight.length; i++) {
      playerRight[i] = loadImage(imgsRight[i]);
      playerRight[i].resize(playerWidth, playerHeight); // Cambiar el tamaño de la imagen
    }
    for (int i = 0; i < imgsLeft.length; i++) {
      playerLeft[i] = loadImage(imgsLeft[i]);
      playerLeft[i].resize(playerWidth, playerHeight); // Cambiar el tamaño de la imagen
    }
    for (int i = 0; i < imgsReposo.length; i++) {
      playerReposo[i] = loadImage(imgsReposo[i]);
      playerReposo[i].resize(playerWidth, playerHeight); // Cambiar el tamaño de la imagen
    }
    currentFrame = 0;
    totalFrames =  imgsRight.length;
    this.frameInterval = frameInterval;
    frameCounter = 0;

    movingLeft = false;
    movingRight = false;
  }

  public void update(float camX) {
    speed.y += gravity;
    position.add(speed);


    if (movingLeft) {
      speed.x = -5;
    } else if (movingRight) {
      speed.x = 5;
    } else {
      speed.x = 0;
    }

    frameCounter++;
    if (frameCounter >= frameInterval) {
      currentFrame = (currentFrame + 1) % totalFrames;
      frameCounter = 0;
    }


    // Limitar el movimiento del jugador a la izquierda
    if (position.x < camX-width/2) {
      position.x = camX-width/2;
    }

    // Verificar colisión con el suelo
    if (position.y> groundLevel) {
      position.y= groundLevel;
      speed.y = 0;
      isJumping = false;
    }
  }

  void display(float camX) {

    if (speed.x==5) {
      image(playerRight[currentFrame], position.x-camX, position.y, playerWidth, playerHeight);
    } else if (speed.x==-5) {
      image(playerLeft[currentFrame], position.x-camX, position.y, playerWidth, playerHeight);
    } else {
      image(playerReposo[currentFrame], position.x-camX, position.y, playerWidth, playerHeight);
    }
  }


  public void handleCollision(ArrayList<Platform> platforms) {
    for (Platform p : platforms) {
      if (position.x+40> p.x && position.x < p.x + p.w) {
        if (position.y + 170 > p.y && position.y +80 < p.y + p.h) {
          position.y = p.y -170;
          speed.y = 0;
          isJumping = false;
        }
      }
    }
  }


  public void jump() {
    if (!isJumping) {
      speed.y = jumpPower;
      isJumping = true;
    }
  }


  void manejarTeclaPresionada() {
    if (key == 'a' || keyCode==LEFT) {
      movingLeft = true;
    } else if (key == 'd' || keyCode == RIGHT) {
      movingRight = true;
    } else if (key == 'w' || keyCode == UP) {
      jump();
    }
  }

  void manejarTeclaLiberada() {
    if ( key == 'd' ||keyCode == RIGHT) {
      movingRight = false;
    } else if (key == 'a' || keyCode == LEFT) {
      movingLeft = false;
    }

}

}
