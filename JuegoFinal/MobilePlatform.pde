class MobilePlatform extends Platform {
  private float velocity;
  private boolean isVertical;
  private float t;
  private float xOriginal, yOriginal;

  public MobilePlatform(float x, float y, float w, float h, float velocity, boolean isVertical) {
    super(x, y, w, h);
    this.velocity = velocity;
    this.isVertical = isVertical;
    this.t = random(TWO_PI);
    this.xOriginal = x;
    this.yOriginal = y;
  }

  public void update() {
    t += velocity;
    if (isVertical) {
      y = sin(t) * 200 + yOriginal; // Ajustar la posición de acuerdo a groundLevel
    } else {
      x = cos(t) * 50 + xOriginal; // Ajustar la posición de acuerdo a la ubicación inicial
    }
  }
}
