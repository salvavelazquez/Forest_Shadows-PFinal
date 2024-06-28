class Enemy extends GameObject {
  private PVector velocity;
  private float gravity = 5;
  private SpriteEnemyGround spriteEnemyGround;
  private int stateEnemyGround;
  private boolean changeDirection;
  private boolean movingRight = false
  //private float leftLimit;   // Límite izquierdo
  //private float rightLimit;  // Límite derecho
 ;

  public Enemy(float x, float y, float speed, boolean changeDirection) {
    this.position = new PVector(x, y);
    this.velocity = new PVector(speed, 0);
    this.spriteEnemyGround = new SpriteEnemyGround();
    this.stateEnemyGround = EnemyGroundStateMachine.MOVE_RIGHT;  //Inicia con el enemigo yendo hacia la derecha
    this.changeDirection = changeDirection;
    //this.leftLimit = x - range / 2;  //Rango del movimiento cuando va hacia la izquierda
    //this.rightLimit= x + range / 2; //Rango del movimiento cuando va hacia la derecha
    
  }
  
  public void display(float camX) {
    spriteEnemyGround.renderEnemyGround(this.stateEnemyGround, this.position, camX);
  }

  public void update(float camX, ArrayList<Platform> platforms) {
     if (abs(position.x - camX) < width) { // Solo actualizar si la cámara está cerca
        // Movimiento horizontal solo si está en una plataforma
        if (movingRight) {
           this.velocity.x = -abs(this.velocity.x);
           this.stateEnemyGround = EnemyGroundStateMachine.MOVE_LEFT;
        } else {
           this.velocity.x = abs(this.velocity.x);
           this.stateEnemyGround = EnemyGroundStateMachine.MOVE_RIGHT;
        }
     
        // Aplicar gravedad
        velocity.y += gravity * Time.getDeltaTime(frameRate);
        this.position.add(this.velocity);
        
        // Verificar colisión con plataformas
        boolean onPlatform = false;
        for (Platform p : platforms) {
            if (position.x + 70 > p.x && position.x + 30 < p.x + p.w) {
                if (position.y + 60 > p.y && position.y + 60 < p.y + p.h) {
                    position.y = p.y - 60;
                    velocity.y = 0;
                    onPlatform = true;
                }
            }
        }
        
        // Cambio de dirección al llegar al borde de una plataforma
        if (changeDirection) {
            if (!onPlatform) {
                movingRight = !movingRight;
            }
        }
    }
    
    
    // Cambiar la dirección si llega los límites del rango de movimiento
    //if (this.position.x <= this.leftLimit) {
    //  this.velocity.x = abs(this.velocity.x); // Mover a la derecha
    //  this.stateEnemyGround = EnemyGroundStateMachine.MOVE_RIGHT; //Carga el estado de los sprites hacia la derecha
    //} else if (this.position.x >= this.rightLimit) {
    //  this.velocity.x = -abs(this.velocity.x); // Mover a la izquierda
    //  this.stateEnemyGround = EnemyGroundStateMachine.MOVE_LEFT;//Carga el estado de los sprites hacia la derecha
    //}
    //this.position.add(this.velocity);
  }
}
