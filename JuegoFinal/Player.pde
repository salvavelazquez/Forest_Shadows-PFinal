class Player {
  PVector position;
  PVector speed;
  float gravity = 0.6;
  float jumpPower = -11;
  boolean isJumping = false;
  boolean isVibrating = false;
  int vibrationFrames = 0;
  float vibrationOffset = 0;
  float groundLevel;

  Player(float startX, float startY, float groundLevel) {
    position = new PVector(startX, startY);
    speed = new PVector(0, 0);
    this.groundLevel = groundLevel;
  }

  void update(float camX) {
    speed.y += gravity;
    position.add(speed);

    // Limitar el movimiento del jugador a la izquierda
    if (position.x < camX) {
      position.x = camX;
    }

    // Verificar colisión con el suelo
    if (position.y > groundLevel) {
      position.y = groundLevel;
      speed.y = 0;
      isJumping = false;
    }

    // Aplicar vibración
    if (isVibrating) {
      applyVibration();
    }
  }

  void display(float camX) {
    fill(255, 0, 0);
    rect(position.x - camX, position.y, 20, 20);
  }

  void startVibration() {
    isVibrating = true;
    vibrationFrames = 20; // Duración de la vibración
  }

  void applyVibration() {
    if (vibrationFrames > 0) {
      vibrationOffset = (vibrationFrames % 2 == 0) ? 5 : -5;
      vibrationFrames--;
    } else {
      isVibrating = false;
      vibrationOffset = 0;
    }
  }

  void handleCollision(ArrayList<Platform> platforms) {
    boolean hitPlatformBottom = false;
    for (Platform p : platforms) {
      if (position.x + 20 > p.x && position.x - 20 < p.x + p.w) {
        if (position.y + 20 > p.y && position.y + 20 < p.y + p.h) {
          position.y = p.y - 20;
          speed.y = 0;
          isJumping = false;
        }
        if (position.y > p.y && position.y < p.y + p.h) {
          hitPlatformBottom = true;
        }
      }
    }

    if (hitPlatformBottom && speed.y < 0) {
      startVibration();
    }
  }

  void moveLeft() {
    speed.x = -5;
  }

  void moveRight() {
    speed.x = 5;
  }

  void jump() {
    if (!isJumping) {
      speed.y = jumpPower;
      isJumping = true;
    }
  }

  void stop() {
    speed.x = 0;
  }
}
