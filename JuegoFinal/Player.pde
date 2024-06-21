/**Clase del jugador*/
class Player {
  private PVector position;
  PVector velocity;
  PVector gravity;
  boolean isJumping;
  //  private PImage playerImage;
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

  public Player(PVector pos, String[] imgsRight, String[] imgsLeft, String[] imgsReposo, int frameInterval) {
    this.position = pos;
    velocity = new PVector(0, 0);
    gravity = new PVector(0, 0.5);
    isJumping = false;
    playerRight = new PImage[imgsRight.length];
    playerLeft = new PImage[imgsLeft.length];
    playerReposo= new PImage[imgsReposo.length];


    for (int i = 0; i < imgsRight.length; i++) {
      playerRight[i] = loadImage(imgsRight[i]);
      playerRight[i].resize(width, height); // Cambiar el tamaño de la imagen
    }
    for (int i = 0; i < imgsLeft.length; i++) {
      playerLeft[i] = loadImage(imgsLeft[i]);
      playerLeft[i].resize(width, height); // Cambiar el tamaño de la imagen
    }
    for (int i = 0; i < imgsReposo.length; i++) {
      playerReposo[i] = loadImage(imgsReposo[i]);
      playerReposo[i].resize(width, height); // Cambiar el tamaño de la imagen
    }
    currentFrame = 0;
    totalFrames =  imgsRight.length;
    this.frameInterval = frameInterval;
    frameCounter = 0;
    this.playerWidth = 200;
    this.playerHeight =200;
    movingLeft = false;
    movingRight = false;
  }


  void update() {
    if (movingLeft) {
      velocity.x = -5;
    } else if (movingRight) {
      velocity.x = 5;
    } else {
      velocity.x = 0;
    }


    velocity.add(gravity);
    position.add(velocity);
    frameCounter++;
    if (frameCounter >= frameInterval) {
      currentFrame = (currentFrame + 1) % totalFrames;
      frameCounter = 0;
    }
    if (position.y > height -500) {
      position.y = height - 500;
      velocity.y = 0;
      isJumping = false;
    }
  }

  void display() {
    imageMode(CENTER);
    if (velocity.x==5) {
      image(playerRight[currentFrame], position.x, position.y, playerWidth, playerHeight);
    } else if (velocity.x==-5) {
      image(playerLeft[currentFrame], position.x, position.y, playerWidth, playerHeight);
    } else {
      image(playerReposo[currentFrame], position.x, position.y, playerWidth, playerHeight);
    }
  }



  void manejarTeclaPresionada() {
    if (key == 'a' || key == 'A') {
      movingLeft = true;
    } else if (key == 'd' || key == 'D') {
      movingRight = true;
    }
  }

  void manejarTeclaLiberada() {
    if (key == 'a' || key == 'A') {
      movingLeft = false;
    } else if (key == 'd' || key == 'D') {
      movingRight = false;
    }
  }
}
