class Player {
  private PVector position;
  private PVector speed;
  private float gravity = 0.6;
  private float jumpPower = -11;
  private boolean isJumping = false;
  private float groundLevel;

  public Player(float startX, float startY, float groundLevel) {
    this.position = new PVector(startX, startY);
    this.speed = new PVector(0, 0);
    this.groundLevel = groundLevel;
  }

  public void update(float camX) {
    speed.y += gravity;
    position.add(speed);

    // Limitar el movimiento del jugador a la izquierda
    if (position.x < camX-width/2) {
      position.x = camX-width/2;
    }

    // Verificar colisión con el suelo
    if (position.y > groundLevel) {
      position.y = groundLevel;
      speed.y = 0;
      isJumping = false;
    }
  }

  public void display(float camX) {
    fill(255, 0, 0);
    rect(position.x - camX, position.y, 20, 20);
  }
  public void handleCollision(ArrayList<Platform> platforms) {
    for (Platform p : platforms) {
      if (position.x + 20 > p.x && position.x - 20 < p.x + p.w) {
        if (position.y + 20 > p.y && position.y + 20 < p.y + p.h) {
          position.y = p.y - 20;
          speed.y = 0;
          isJumping = false;
        }
      }
    }
  }

  public void moveLeft() {
    speed.x = -5;
  }

  public void moveRight() {
    speed.x = 5;
  }

  public void jump() {
    if (!isJumping) {
      speed.y = jumpPower;
      isJumping = true;
    }
  }

  public void stop() {
    speed.x = 0;
  }
}
