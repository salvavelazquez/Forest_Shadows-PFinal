class PlatformEnMovimiento extends Platform {
  private float velocidad;
  private boolean esVertical;
  private float t;
  private float xOriginal, yOriginal;

  PlatformEnMovimiento(float x, float y, float w, float h, float velocidad, boolean esVertical) {
    super(x, y, w, h);
    this.velocidad = velocidad;
    this.esVertical = esVertical;
    this.t = random(TWO_PI);
    this.xOriginal = x;
    this.yOriginal = y; 
  }

  void update() {
    t += velocidad;
    if (esVertical) {
      y = sin(t) * 200 + yOriginal; // Ajustar la posición de acuerdo a groundLevel
    } else {
      x = cos(t) * 50 + xOriginal; // Ajustar la posición de acuerdo a la ubicación inicial
    }
  }
}
