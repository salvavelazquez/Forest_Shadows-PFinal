class Player extends GameObject {
  private PVector speed;
  private float gravity = 10;
  private float jumpPower = -300;
  private boolean isJumping = false;
  private float angleVision = radians(40);
  private float fovRadius = 125;
  private float groundLevel;
  private SpritePlayer spritePlayer;
  private int statePlayer;
  private float  camX = -width/2;
  private boolean movingLeft;
  private boolean movingRight;
  private boolean spacePress;
  private Vector vectorCharacter;


  //Vida del jugador
  private int lives;
  private boolean invulnerable;
  private float invulnerableTime;
  private float invulnerableDuration = 1.0; // Duración de la invulnerabilidad en segundos

  //Variables del Powerup
  private int powerUpCount = 0;
  private boolean powerUpActive = false;
  private float powerUpTimer = 0;
  private static final float POWER_UP_DURATION = 2.0;


  public Player(float x, float y, float groundLevel ) {
    this.position = new PVector(x, y);
    this.groundLevel = groundLevel;
    this.speed = new PVector(0, 0);
    this.spritePlayer = new SpritePlayer();
    this.statePlayer = PlayerStateMachine.IDLE;
    this.lives = 5;
    this.invulnerable = false;
    this.invulnerableTime = 0;
    this.movingLeft = false;
    this.movingRight = false;
    this.spacePress=false;
    // Inicializar los vectores
    vectorCharacter = new Vector(new PVector(x, y), new PVector(1, 0));
  }
  public void update() {
    speed.y += gravity * Time.getDeltaTime(frameRate);
    position.add(speed);
    if (movingLeft) {
      statePlayer = PlayerStateMachine.MOVE_LEFT;
      speed.x = -7;
    } else if (movingRight) {
      statePlayer = PlayerStateMachine.MOVE_RIGHT;
      speed.x = 7;
    } else {
      speed.x = 0;
      statePlayer = PlayerStateMachine.IDLE;
    }

    // Actualizar el temporizador del power-up
    if (powerUpActive) {
      powerUpTimer += Time.getDeltaTime(frameRate);
      if (powerUpTimer >= POWER_UP_DURATION) {
        powerUpActive = false;
        powerUpTimer = 0;
        spacePress = false; // Apaga el efecto del power-up
      }
    }
    if (spacePress) {
      fieldVision();
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

    // Actualizar el tiempo de invulnerabilidad
    if (invulnerable) {
      invulnerableTime += Time.getDeltaTime(frameRate);
      if (invulnerableTime >= invulnerableDuration) {
        invulnerable = false;
        invulnerableTime = 0;
      }
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

  public void addPowerUp() {
    this.powerUpCount+=3 ;
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

  public void handleEnemyCollision(ArrayList<Enemy> enemies) {
    if (enemies == null || enemies.isEmpty()|| invulnerable) {
      return;
    }
    for (Enemy enemy : enemies) {
      if (willCollideWithEnemy(this.position, enemy)) {
        invulnerable = true;
        invulnerableTime = 0;
        resetPos();
        if (lives <2) {
          gameOver();
        }
        break;
      }
    }
  }

  private boolean willCollideWithEnemy(PVector playerPos, Enemy enemy) {
    // Verificar colisión con enemigo
    float collisionRange = 50; // Ajustar según sea necesario
    return PVector.dist(playerPos, enemy.position) < collisionRange;
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

  public void fieldVision() {
    noStroke();
    fill(0, 255, 0, 127); // Color verde translúcido
    float startAngle = atan2(vectorCharacter.getDestiny().y, vectorCharacter.getDestiny().x) - angleVision;
    float endAngle = atan2(vectorCharacter.getDestiny().y, vectorCharacter.getDestiny().x) + angleVision;

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
          if (abs(angleToEnemy) < angleVision) {
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
      jumping.play();
      //statePlayer =
    }
  }

  public void resetPos() {
    position.x=100;
    position.y=300;
  }

  public void handleKeyPressed() {
    if (key == 'a' ||key == 'A' || keyCode==LEFT) {

      movingLeft = true;
    } else if (key == 'd' || key == 'D' ||keyCode == RIGHT) {
      movingRight = true;
    } else if (key == 'w' ||key == 'W' || keyCode == UP) {
      jump();
    } else if (keyCode==32) {
      if (powerUpCount > 0 && !powerUpActive) {
        spacePress = true;
        powerUpActive = true;
        powerUpTimer = 0;
        this.powerUpCount--;
        println(this.powerUpCount);
      }
    }
  }

  public void handleKeyReleased() {
    if ( key == 'd' || key == 'D' ||keyCode == RIGHT) {
      movingRight = false;
    } else if (key == 'a' || key == 'A' || keyCode == LEFT) {
      movingLeft = false;
    } else if (keyCode==32) {
      //spacePress=false;
    }
  }
  public void win() {
    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Winner!", -50, 0);
    file.stop();
    win.play();
    noLoop();
  }
  public void gameOver() {
    fill(255);
    textSize(50);
    text("Game Over", -90, 0);
    noLoop();
    file.stop();
    gameOver.play();
  }
}
