class Egg {
  private PVector posicion;
  private PVector velocidad;
  private PVector gravedad = new PVector(0, 0.1);
  private boolean enemyCreated; // Nueva bandera
  boolean isFalling;

  public Egg(PVector posicion, PVector velocidad) {
    this.posicion = posicion;
    this.velocidad = velocidad;
    this.enemyCreated = false; // Inicializar como falso
    this.isFalling = true;
  }

  public void mover() {
    velocidad.add(gravedad);
    posicion.add(velocidad);
  }

  public void display() {
    ellipse(posicion.x, posicion.y, 20, 20);
  }

  public boolean isEnemyCreated() {
    return enemyCreated;
  }

  public void setEnemyCreated(boolean enemyCreated) {
    this.enemyCreated = enemyCreated;
  }

  public PVector getPosicion() {
    return posicion;
  }

  public void handleCollision(ArrayList<Platform> platforms) {
    platforms.sort((p1, p2) -> Float.compare(p1.x, p2.x));
    for (Platform p : platforms) {
      if (isInSweepRange(this.posicion, p)) {
        PVector nextPosition = PVector.add(this.posicion, this.velocidad);
        if (willCollide(this.posicion, nextPosition, p)) {
          this.posicion.y = p.y - 10; // Ajusta la posición del huevo encima de la plataforma
          this.velocidad.y = 0;
          this.isFalling = false; // Detiene la caída del huevo
          break;
        }
      }
    }
  }

  private boolean isInSweepRange(PVector position, Platform platform) {
    float sweepRange = 900; // Definir un rango de barrido adecuado
    return Math.abs(position.x - platform.x) <= sweepRange;
  }

  private boolean willCollide(PVector currentPos, PVector nextPos, Platform platform) {
    if (currentPos.y < platform.y && nextPos.y + 40 >= platform.y) {
      if (currentPos.x > platform.x - 30 && currentPos.x < platform.x + platform.w + 40) {
        return true;
      }
    }
    return false;
  }
}
