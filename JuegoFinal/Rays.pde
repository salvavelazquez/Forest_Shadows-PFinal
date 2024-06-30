class Rays {
  private int flashDuration;
  private color rayColor;
  private int raySize;

  public Rays() {
    this.flashDuration = 0;
    this.rayColor = color(255, 255, 0);
    this.raySize = 2;
  }

  public void display() {
    if (flashDuration > 0) {
      // Temporada de relámpagos: fondo gris oscuro
      background(200);
      flashDuration--;
    }

    if (random(1) < 0.03) { // 3% de probabilidad de rayo en cada cuadro
      flashDuration = 5; // Duración del flash en cuadros
      stroke(rayColor);
      strokeWeight(raySize);
      float startX = random(-width/2, width/2);
      float startY = -height/2;
      // Se dibuja los detellos de rayos y se establece sus ubicaciones desde x a y
      for (int i = 0; i < 20; i++) {
        float endX = startX + random(-50, 50);
        float endY = startY + random(10, 100);
        line(startX, startY, endX, endY);
        startX = endX;
        startY = endY;
      }
      noStroke();
    }
  }
}
