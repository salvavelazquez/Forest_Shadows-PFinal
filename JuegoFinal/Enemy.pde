class Enemy extends GameObject {
  private PVector velocity;
  PVector gravedad = new PVector(0, 0.1);
  private SpriteEnemyGround spriteEnemyGround;
  private int stateEnemyGround;
  private float leftLimit;   // Límite izquierdo
  private float rightLimit;  // Límite derecho

  public Enemy(float x, float y, float speed, float range) {
    this.position = new PVector(x, y);
    this.velocity = new PVector(speed, 0);
    this.spriteEnemyGround = new SpriteEnemyGround();
    this.stateEnemyGround = EnemyGroundStateMachine.MOVE_RIGHT;  //Inicia con el enemigo yendo hacia la derecha
    this.leftLimit = x - range / 2;  //Rango del movimiento cuando va hacia la izquierda
    this.rightLimit= x + range / 2; //Rango del movimiento cuando va hacia la derecha
  }

  public void update() {
    // Cambiar la dirección si llega los límites del rango de movimiento
    if (this.position.x <= this.leftLimit) {
      this.velocity.x = abs(this.velocity.x); // Mover a la derecha
      this.stateEnemyGround = EnemyGroundStateMachine.MOVE_RIGHT; //Carga el estado de los sprites hacia la derecha
    } else if (this.position.x >= this.rightLimit) {
      this.velocity.x = -abs(this.velocity.x); // Mover a la izquierda
      this.stateEnemyGround = EnemyGroundStateMachine.MOVE_LEFT;//Carga el estado de los sprites hacia la derecha
    }
    this.position.add(this.velocity);
  }

  public void display(float camX) {
    spriteEnemyGround.renderEnemyGround(this.stateEnemyGround, this.position, camX);
  }
}
