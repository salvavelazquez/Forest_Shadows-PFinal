class Platform {
  float x, y, w, h;

  Platform(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public void display(float camX, PImage platformImage) {
    for (int i = 0; i < w; i += platformImage.width) {
      image(platformImage, x + i - camX, y, platformImage.width, h);
    }
  }
}
