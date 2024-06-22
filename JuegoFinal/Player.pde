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
  private boolean movingLeft;
  private boolean movingRight;
  // Inicializar los vectores
  Vector vectorPersonaje;
  Vector vectorPersonajeEnemigo;
  
  
  public Player(float x, float y, float groundLevel ) {
    this.position = new PVector(x, y);
    this.groundLevel = groundLevel;
    this.speed = new PVector(0, 0);
    this.spritePlayer = new SpritePlayer();
    this.statePlayer = PlayerStateMachine.IDLE;
    this.lives = 4;
    this.movingLeft = false;
    this.movingRight = false;
    // Inicializar los vectores
    vectorPersonaje = new Vector(new PVector(x, y), new PVector(1, 0));
    vectorPersonajeEnemigo = new Vector(new PVector(x, y), new PVector(1, 0));
  }
  public void update() {
    speed.y += gravity * Time.getDeltaTime(frameRate);
    position.add(speed);
    if (movingLeft) {
      statePlayer = PlayerStateMachine.MOVE_LEFT;
      speed.x = -5;
    } else if (movingRight) {
      statePlayer = PlayerStateMachine.MOVE_RIGHT;
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

  public void display() {
    this.camX = max(this.position.x, 0);
    spritePlayer.renderPlayer(this.statePlayer, this.position, this.camX);
    campoVision() ;
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

  void campoVision() {
    float anguloVision = radians(15);
    noStroke();
    fill(0, 255, 0, 127); // Color verde translúcido
    float fovRadius = 300;
    float startAngle = atan2(vectorPersonaje.getDestino().y, vectorPersonaje.getDestino().x) - anguloVision;
    float endAngle = atan2(vectorPersonaje.getDestino().y, vectorPersonaje.getDestino().x) + anguloVision;

    if (speed.x > 0) {
      arc(position.x-this.camX, position.y+20, fovRadius * 2, fovRadius * 2, startAngle, endAngle);
    } else if (speed.x < 0) {
      pushMatrix();
      translate(position.x-this.camX-50, position.y+20);
      rotate(PI);
      arc(0, 0, fovRadius * 2, fovRadius * 2, startAngle, endAngle);
      popMatrix();
    } else {
    }
  }
  public void killEnemiesInView(ArrayList<Enemy> enemies) {
    float anguloVision = radians(15);
    float fovRadius = 300;
    PVector direction = new PVector(0, 0);

    if (movingRight) {
      direction = new PVector(1, 0);
    } else if (movingLeft) {
      direction = new PVector(-1, 0);
    }

    if (direction.mag() > 0) {
      for (int i = enemies.size() - 1; i >= 0; i--) {
        Enemy enemy = enemies.get(i);
        PVector toEnemy = PVector.sub(enemy.position, this.position);
        float distance = toEnemy.mag();
        if (distance < fovRadius) {
          float angleToEnemy = PVector.angleBetween(direction, toEnemy);
          if (abs(angleToEnemy) < anguloVision) {
            enemies.remove(i); // Elimina el enemigo del ArrayList
          }
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

  public void resetPos() {
    position.x=100;
    position.y=300;
  }

  public void manejarTeclaPresionada() {
    if (key == 'a' || keyCode==LEFT) {

      movingLeft = true;
    } else if (key == 'd' || keyCode == RIGHT) {
      movingRight = true;
    } else if (key == 'w' || keyCode == UP) {
      jump();
    }
  }

  public void manejarTeclaLiberada() {
    if ( key == 'd' ||keyCode == RIGHT) {
      movingRight = false;
    } else if (key == 'a' || keyCode == LEFT) {
      movingLeft = false;
    }
  }
}
