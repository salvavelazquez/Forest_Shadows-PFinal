class Egg {
  private PVector posicion;
  private PVector speed;
  private PVector gravity = new PVector(0, 0.1);
  private boolean isFalling;  //Está cayendo
  private boolean onPlatform; //Está sobre la plataforma

  public Egg(PVector posicion, PVector speed) {
    this.posicion = posicion;
    this.speed = speed;
    this.isFalling = true;
    this.onPlatform = false;
  }

  public void move() {
    if (isFalling) {
      speed.add(gravity);
      posicion.add(speed);
    }
  }

  public void display() {
    ellipse(posicion.x, posicion.y, 20, 20);
  }

  public PVector getPosicion() {
    return posicion;
  }
  public boolean isFalling() {
    return isFalling;
  }
  public boolean isOnPlatform() {
    return onPlatform;
  }

  public void handleCollision(ArrayList<Platform> platforms, float camX) {
    platforms.sort((p1, p2) -> Float.compare(p1.x, p2.x));
    for (Platform p : platforms) {
      if (isInSweepRange(this.posicion, p, camX)) {
        PVector nextPosition = PVector.add(this.posicion, this.speed);
        if (willCollide(this.posicion, nextPosition, p, camX)) {
          this.posicion.y = p.y - 10; // Ajusta la posición del huevo encima de la plataforma
          this.speed.y = 0;
          this.isFalling = false; // Detiene la caída del huevo
          this.onPlatform = true; // Marca que está sobre una plataforma
          break;
        }
      }
    }
  }

  private boolean isInSweepRange(PVector position, Platform platform, float camX) {
    float sweepRange = 900; // Definir un rango de barrido adecuado
    return Math.abs((position.x+camX) - platform.x) <= sweepRange;
  }

  private boolean willCollide(PVector currentPos, PVector nextPos, Platform platform, float camX) {
    if (currentPos.y < platform.y && nextPos.y + 40 >= platform.y) {
      if ((currentPos.x+camX) > platform.x- 30 && (currentPos.x+camX) < platform.x + platform.w + 40) {
        return true;
      }
    }
    return false;
  }
}
