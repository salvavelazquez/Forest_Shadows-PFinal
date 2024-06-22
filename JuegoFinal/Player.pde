class Player extends GameObject {
  private PVector speed;
  private int lives;
  private float gravity = 10;
  private float jumpPower = -300;
  private boolean isJumping = false;
  private float groundLevel;
  private SpritePlayer spritePlayer;
  private int statePlayer;
  private float  camX = -width/2;

  // ---- VARIABLES SPRITES ----- //
  int playerWidth, playerHeight;
  PImage[] playerRight; /**Imagen del sprite del jugador*/
  PImage[] playerLeft; /**Imagen del sprite del jugador*/
  PImage[] playerReposo; /**Imagen del sprite del jugador*/
  boolean movingLeft;
  boolean movingRight;
  int currentFrame;/**Posición flotante del cuadro de imagen actual en la transición*/
  int totalFrames;
  int frameInterval;/**Posición flotante del siguiente cuadro de imagen en la transición*/
  int frameCounter;

  public Player(float x, float y, float groundLevel, int frameInterval ) {
    this.position = new PVector(x, y);
    this.speed = new PVector(0, 0);
    this.groundLevel = groundLevel;
    this.spritePlayer = new SpritePlayer();
    this.statePlayer = PlayerStateMachine.IDLE;
    this.playerWidth = 200;
    this.playerHeight =200;
    this.statePlayer = PlayerStateMachine.IDLE;


    lives = 4;

    currentFrame = 0;

    this.frameInterval = frameInterval;
    frameCounter = 0;
    movingLeft = false;
    movingRight = false;
  }
  public void update() {
    speed.y += gravity * Time.getDeltaTime(frameRate);
    position.add(speed);
    if (movingLeft) {
      statePlayer = PlayerStateMachine.LEFT;
      speed.x = -5;
    } else if (movingRight) {
      statePlayer = PlayerStateMachine.RIGHT;
      speed.x = 5;
    } else {
      speed.x = 0;
      statePlayer = PlayerStateMachine.IDLE;
    }

 
    // Limitar el movimiento del jugador a la izquierda
    this.camX = max(this.position.x, 0);
    if (position.x < camX-width/2) {
      position.x = camX-width/2;
    }

    // Verificar colisión con el suelo
    if (position.y> groundLevel) {
      position.y= groundLevel;
      speed.y = 0;
      isJumping = false;
    }

    //println(position.y);
    //Verificar si cayó de la plataforma
    if (position.y>300) {
      lives--;
      resetPos();
    }

    //Detiene el juego al peder las vidas
    if (lives==0) {
      fill(255);
      textSize(50);
      text("Game Over", 0, 0);
      noLoop();
    }
  }

  void display() {
    this.camX = max(this.position.x, 0);
    spritePlayer.renderPlayer(this.statePlayer, this.position, this.camX);
  }


  public void handleCollision(ArrayList<Platform> platforms) {
    for (Platform p : platforms) {
      if (this.position.x + 70 > p.x && position.x - 20 < p.x + p.w) {
        if (this.position.y + 90 > p.y && position.y + 90 < p.y + p.h) {
          this.position.y = p.y - 90;
          this.speed.y = 0;
          isJumping = false;
        }
      }
    }
  }


  public void jump() {
    if (!isJumping) {
      speed.y = jumpPower* Time.getDeltaTime(frameRate);
      isJumping = true;
    }
  }

  void resetPos() {
    position.x=100;
    position.y=300;
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
