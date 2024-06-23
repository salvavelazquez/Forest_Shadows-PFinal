class Rays {
  private int flashDuration;

  public Rays() {
    this.flashDuration = 0;
  }

  public void display() {
    if (flashDuration > 0) {
      // Temporada de relámpagos: fondo gris oscuro
      background(200);
      flashDuration--;
    }

    if (random(1) < 0.03) { // 3% de probabilidad de rayo en cada cuadro
      flashDuration = 5; // Duración del flash en cuadros
      stroke(255, 255, 0);
      strokeWeight(2);
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
    }
  }
}
