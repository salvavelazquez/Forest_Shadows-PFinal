class Enemy extends GameObject {
  private PVector velocity;
  private float gravity = 5;
  private SpriteEnemyGround spriteEnemyGround;
  private int stateEnemyGround;

  public Enemy(float x, float y, float speed) {
    this.position = new PVector(x, y);
    this.velocity = new PVector(speed, 0);
    this.spriteEnemyGround = new SpriteEnemyGround();
    this.stateEnemyGround = EnemyGroundStateMachine.MOVE_RIGHT;  //Inicia con el enemigo yendo hacia la derecha
  }

  public void display(float camX) {
    spriteEnemyGround.renderEnemyGround(this.stateEnemyGround, this.position, camX);
  }

  public void update( ArrayList<Platform> platforms) {
    // Aplica gravedad
    velocity.y += gravity * Time.getDeltaTime(frameRate);
    this.position.add(this.velocity); 
    // Ordena las plataformas según su posición en el eje X
    platforms.sort((p1, p2) -> Float.compare(p1.x, p2.x));
    //Verificar colisión con plataformas
    boolean onPlatform = false;
    for (Platform p : platforms) {
      if (isInSweepRange(this.position, p)) {
        PVector nextPosition = PVector.add(this.position, this.velocity);

        if (willCollide(this.position, nextPosition, p)) {
          position.y = p.y - 60;
          velocity.y = 0;
          onPlatform = true;
        }
      }
    }
  }

  private boolean isInSweepRange(PVector position, Platform platform) {
    // Verificar si la plataforma está en el rango de barrido del jugador
    float sweepRange = 900; // Definir un rango de barrido adecuado
    return Math.abs(position.x - platform.x) <= sweepRange;
  }
  
  private boolean willCollide(PVector currentPos, PVector nextPos, Platform platform) {
    // Barrido en el eje Y
    if (currentPos.y + 60 > platform.y && nextPos.y + 60 < platform.y + platform.h) {
      if (currentPos.x + 70 > platform.x && nextPos.x + 30 < platform.x + platform.w) {
        return true;
      }
    }
    return false;
  }
}
