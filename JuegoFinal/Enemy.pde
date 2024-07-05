class Enemy extends GameObject {
  private PVector velocity;
  private float gravity = 5;
  private SpriteEnemyGround spriteEnemyGround;
  private int stateEnemyGround;
  private Player player; // Referencia al jugador
  private float speed;
  private boolean active;

  public Enemy(float x, float y, float speed, Player player) {
    this.position = new PVector(x, y);
    this.velocity = new PVector(0, 0);
    this.spriteEnemyGround = new SpriteEnemyGround();
    this.stateEnemyGround = EnemyGroundStateMachine.MOVE_RIGHT;  //Inicia con el enemigo yendo hacia la derecha
    this.speed = speed;
    this.player = player; // Inicializar la referencia al jugador
    this.active = false; // Inicialmente inactivo
  }

  public void display(float camX) {
    if (!active) return;
    spriteEnemyGround.renderEnemyGround(this.stateEnemyGround, this.position, camX);
  }

  public void activate(PVector position) {
    setPosition(position); // Establecer la posición inicial
    this.active = true; // Activar el enemigo
  }

  public void deactivate() {
    this.active = false; // Desactivar el enemigo
    setPosition(new PVector(0, 0)); // Reiniciar la posición a (0, 0)
  }



  public void update( ArrayList<Platform> platforms) {
    if (!active) return; // No hacer nada si no está activo
    // Aplica gravedad
    velocity.y += gravity * Time.getDeltaTime(frameRate);
    // Calcular la dirección hacia el jugador
    PVector direction = PVector.sub(player.position, this.position);
    direction.normalize();
    direction.mult(speed * Time.getDeltaTime(frameRate));
    // Añadir la dirección a la velocidad
    velocity.x = direction.x;
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
          break;
        }
      }
    }
    // Si el enemigo no está en ninguna plataforma, continuar aplicando gravedad
    if (!onPlatform) {
      velocity.y += gravity * Time.getDeltaTime(frameRate);
    }


    // Desactivar el enemigo si está fuera de los límites
    if (position.y > 600) {
      deactivate();
    }
    // Actualizar el estado del enemigo basado en la dirección del movimiento
    if (velocity.x > 0) {
      stateEnemyGround = EnemyGroundStateMachine.MOVE_RIGHT;
    } else if (velocity.x < 0) {
      stateEnemyGround = EnemyGroundStateMachine.MOVE_LEFT;
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

  public boolean isActive() {
    return active;
  }
}
