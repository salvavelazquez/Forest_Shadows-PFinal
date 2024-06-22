class Enemy {
  PVector position;
  PVector velocity;
  PImage[] enemyImagesRight;
  PImage[] enemyImagesLeft;
   int currentFrame;
  int totalFrames;
  int frameInterval;
  int frameCounter;
 int enemyWidth, enemyHeight;
  
  Enemy(float x, float y, float speed, String[] imgsRight, String[] imgsLeft, int frameInterval,int width, int height) {
    position = new PVector(x, y);
    velocity = new PVector(speed, 0);
   enemyImagesRight = new PImage[imgsRight.length];
    enemyImagesLeft = new PImage[imgsLeft.length];
    for (int i = 0; i < imgsRight.length; i++) {
      enemyImagesRight[i] = loadImage(imgsRight[i]);
      enemyImagesRight[i].resize(width, height); // Cambiar el tamaño de la imagen
    }
    for (int i = 0; i < imgsLeft.length; i++) {
      enemyImagesLeft[i] = loadImage(imgsLeft[i]);
      enemyImagesLeft[i].resize(width, height); // Cambiar el tamaño de la imagen
    }
    currentFrame = 0;
    totalFrames =  imgsRight.length;;
    this.frameInterval = frameInterval;
    frameCounter = 0;
       this.enemyWidth = width;
    this.enemyHeight = height;
  }
  
  void update() {
    position.add(velocity);
    if (position.x > width - 50 || position.x < 0) {
      velocity.x *= -1;
    }
      frameCounter++;
    if (frameCounter >= frameInterval) {
      currentFrame = (currentFrame + 1) % totalFrames;
      frameCounter = 0;
    }
  }
  
  void display(float camX) {
     if (velocity.x > 0) {
      image(enemyImagesRight[currentFrame], position.x-camX, position.y, enemyWidth, enemyHeight);
    } else {
      image(enemyImagesLeft[currentFrame], position.x-camX, position.y, enemyWidth, enemyHeight);
    }
  }
}
