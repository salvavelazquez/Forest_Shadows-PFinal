class Button {
  private float x, y;
  private float widthButton, heightButton;
  private String text;

  public Button(float x, float y, float widthButton, float heightButton, String text) {
    this.x = x;
    this.y = y;
    this.widthButton = widthButton;
    this.heightButton = heightButton;
    this.text = text;
  }

  public void display() {
    noStroke();
    fill(227, 96, 14, 200);
    if (mouseOnTop()) {
      fill(119, 50, 250, 200);
      //fill(50, 100, 250, 200);
    }
    rect(x, y, widthButton, heightButton, 10);
    fill(255);
    textSize(45);
    textAlign(CENTER, CENTER);
    text(text, x + widthButton / 2, y + heightButton / 2);
  }

  public boolean mouseOnTop() {
    return mouseX > x && mouseX < x + widthButton && mouseY > y && mouseY < y + heightButton;
  }
}
