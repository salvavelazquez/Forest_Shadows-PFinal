class Enemy extends GameObject{
  private PVector velocity;
  private SpriteEnemyGround spriteEnemyGround;
  private int stateEnemyGround;
  
  public Enemy(float x, float y, float speed) {
    this.position = new PVector(x, y);
    this.velocity = new PVector(speed, 0);
    this.spriteEnemyGround = new SpriteEnemyGround();
    this.stateEnemyGround = EnemyGroundStateMachine.MOVE_LEFT;
  }
  public void update() {
    this.position.add(this.velocity);
    if (this.position.x > width - 50 || this.position.x < 0) {
      this.velocity.x *= -1;
    }
  }
  
  public void display() {
    spriteEnemyGround.renderEnemyGround(this.stateEnemyGround,this.position);
  }
}
