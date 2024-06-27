class Button {
  private float x, y;
  private float ancho, alto;
  private String texto;

  public Button(float x, float y, float ancho, float alto, String texto) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
    this.texto = texto;
  }

  public void display() {
    noStroke();
    fill(227,96,14,200);
    if (mouseEstaEncima()) {
      fill(119, 50, 250, 200);
      //fill(50, 100, 250, 200);
    }
    rect(x, y, ancho, alto, 10);
    fill(255);
    textSize(45);
    textAlign(CENTER, CENTER);
    text(texto, x + ancho / 2, y + alto / 2);
  }

  boolean mouseEstaEncima() {
    return mouseX > x && mouseX < x + ancho && mouseY > y && mouseY < y + alto;
  }
}
