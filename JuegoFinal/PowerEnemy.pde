class Pelota {
  PVector posicion;
  PVector velocidad;
  PVector gravedad = new PVector(0, 0.1);


  Pelota(PVector posicion, PVector velocidad) {
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
