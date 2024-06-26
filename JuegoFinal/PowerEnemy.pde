class Pelota {
  PVector pos;
  float diametro;
  float angulo;
  float velocidadAngulo;
  
  Pelota(float x, float y, float diam, float angulo, float velAngulo) {
    this.pos = new PVector(x, y);
    this.diametro = diam;
    this.angulo = angulo;
    this.velocidadAngulo = velAngulo;
  }

  void display() {
    ellipse(pos.x, pos.y, diametro, diametro);
  }
}
