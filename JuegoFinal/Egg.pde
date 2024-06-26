class Egg {

  private PVector posicion;
  private  PVector velocidad;
  private  PVector gravedad = new PVector(0, 0.1);


  Egg(PVector posicion, PVector velocidad) {
    this.posicion = posicion;
    this.velocidad = velocidad;
  }

  void mover() {
    velocidad.add(gravedad);
    posicion.add(velocidad);
  }

  void display() {
    ellipse(posicion.x, posicion.y, 20, 20);
  }
}
