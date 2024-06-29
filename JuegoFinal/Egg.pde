class Egg {
  private PVector posicion;
  private PVector velocidad;
  private PVector gravedad = new PVector(0, 0.1);
  private boolean isFalling;
  private boolean onPlatform; //

  public Egg(PVector posicion, PVector velocidad) {
    this.posicion = posicion;
    this.velocidad = velocidad;
    this.isFalling = true;
    this.onPlatform = false;

  }

  public void mover() {
    velocidad.add(gravedad);
    posicion.add(velocidad);
  }

  public void display() {
    ellipse(posicion.x, posicion.y, 20, 20);
  }

  public PVector getPosicion() {
    return posicion;
  }
    public boolean isOnPlatform() {
    return onPlatform;
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
          this.onPlatform = true; // Marca que está sobre una plataforma
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
