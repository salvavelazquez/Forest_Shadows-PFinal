class Egg {
  private PVector posicion;
  private  PVector velocidad;
  private  PVector gravedad = new PVector(0, 0.1);


  public Egg(PVector posicion, PVector velocidad) {
    this.posicion = posicion;
    this.velocidad = velocidad;
  }

  public void mover() {
    velocidad.add(gravedad);
    posicion.add(velocidad);
  }

  public void display() {
    ellipse(posicion.x, posicion.y, 20, 20);
  }
}
