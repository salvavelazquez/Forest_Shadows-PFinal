class Egg {
  private PVector posicion;
  private PVector velocidad;
  private PVector gravedad = new PVector(0, 0.1);
  private boolean enemyCreated; // Nueva bandera

  public Egg(PVector posicion, PVector velocidad) {
    this.posicion = posicion;
    this.velocidad = velocidad;
    this.enemyCreated = false; // Inicializar como falso
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
}
