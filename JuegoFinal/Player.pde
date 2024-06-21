class Player {
  private PVector position;
  private PVector speed;
  private float gravity = 10;
  private float jumpPower = -250;
  private boolean isJumping = false;
  private float groundLevel;

  public Player(float startX, float startY, float groundLevel) {
    this.position = new PVector(startX, startY);
    this.speed = new PVector(0, 0);
    this.groundLevel = groundLevel;
  }

  public void update(float camX) {
    speed.y += gravity * Time.getDeltaTime(frameRate);
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
    rect(position.x - camX, position.y, 50, 50);
  }
  public void handleCollision(ArrayList<Platform> platforms) {
    for (Platform p : platforms) {
      if (this.position.x + 50 > p.x && position.x - 20 < p.x + p.w) {
        if (this.position.y + 50 > p.y && position.y + 20 < p.y + p.h) {
          this.position.y = p.y - 50;
          this.speed.y = 0;
          isJumping = false;
        }
      }
    }
  }

  public void moveLeft() {
    speed.x = -250 * Time.getDeltaTime(frameRate);
  }

  public void moveRight() {
    speed.x = 250 * Time.getDeltaTime(frameRate);
  }

  public void jump() {
    if (!isJumping) {
      speed.y = jumpPower* Time.getDeltaTime(frameRate);
      isJumping = true;
    }
  }

  public void stop() {
    speed.x = 0;
  }
}
