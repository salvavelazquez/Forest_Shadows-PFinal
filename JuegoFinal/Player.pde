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
  private boolean spacePress;
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
    this.spacePress=false;
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


    if (spacePress) {
      campoVision();
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
      text("Game Over", -90, 0);
      noLoop();
    }

    // Verificar colisión con el castillo para ganar el juego
    if (position.x  >= 8850 && position.x <= 8950 &&
      position.y + 90 >= 300 && position.y <= 290) {
      win();
    }
  }

  public void display() {
    this.camX = max(this.position.x, 0);
    spritePlayer.renderPlayer(this.statePlayer, this.position, this.camX);
  }

  public void handleCollision(ArrayList<Platform> platforms) {
    // Ordena las plataformas según su posición en el eje X
    platforms.sort((p1, p2) -> Float.compare(p1.x, p2.x));
    for (Platform p : platforms) {
      if (isInSweepRange(this.position, p)) {
        PVector nextPosition = PVector.add(this.position, this.speed);
        if (willCollide(this.position, nextPosition, p)) {
          this.position.y = p.y - 90;
          this.speed.y = 0;
          isJumping = false;
        }
      }
    }
  }

  private boolean isInSweepRange(PVector position, Platform platform) {
    // Verifica si la plataforma está en el rango de barrido del jugador
    float sweepRange = 900; // Definir un rango de barrido adecuado
    return Math.abs(position.x - platform.x) <= sweepRange;
  }

  private boolean willCollide(PVector currentPos, PVector nextPos, Platform platform) {
    // Barrido en el eje Y
    if (currentPos.y < platform.y && nextPos.y + 90 >= platform.y) {
      if (currentPos.x > platform.x-30 && currentPos.x < platform.x + platform.w+40) {
        return true;
      }
    }
    return false;
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
        //if (1000<distance) {  //Verifica si el enemigo está muy lejos del jugador
        //  enemies.remove(i); // Elimina el enemigo del ArrayList
        //}

        if ((distance < fovRadius && spacePress) ) {
          float angleToEnemy = PVector.angleBetween(direction, toEnemy);
          if (abs(angleToEnemy) < anguloVision) {
            enemy.deactivate();
            //enemies.remove(i); // Elimina el enemigo del ArrayList
          }
        }
      }
    }
  }

  public void jump() {
    if (!isJumping) {
      speed.y = jumpPower* Time.getDeltaTime(frameRate);
      isJumping = true;
      //statePlayer =
    }
  }

  public void resetPos() {
    position.x=100;
    position.y=300;
  }

  public void manejarTeclaPresionada() {
    if (key == 'a' ||key == 'A' || keyCode==LEFT) {

      movingLeft = true;
    } else if (key == 'd' || key == 'D' ||keyCode == RIGHT) {
      movingRight = true;
    } else if (key == 'w' ||key == 'W' || keyCode == UP) {
      jump();
    } else if (keyCode==32) {
      spacePress=true;
    }
  }

  public void manejarTeclaLiberada() {
    if ( key == 'd' || key == 'D' ||keyCode == RIGHT) {
      movingRight = false;
    } else if (key == 'a' || key == 'A' || keyCode == LEFT) {
      movingLeft = false;
    } else if (keyCode==32) {
      spacePress=false;
    }
  }
  public void win() {
    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Winner!", -50, 0);
    noLoop();
  }
}
