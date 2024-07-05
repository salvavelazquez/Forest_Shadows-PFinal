class Vector {
  private PVector origin;
  private PVector destiny;

  public Vector() {
  }

  public Vector(PVector origin, PVector destiny) {
    this.origin = origin;
    this.destiny = destiny;
  }

  public void display() {
    strokeWeight(3);
    line(origin.x, origin.y, origin.x + destiny.x, origin.y + destiny.y);
  }

  public float getDotProduct(Vector vector) {
    return PVector.dot(this.getDestiny(), vector.getDestiny());
  }

  public void setOrigin(PVector origin) {
    this.origin = origin;
  }

  public PVector getOrigin() {
    return this.origin;
  }

  public void setDestiny(PVector destiny) {
    this.destiny = destiny;
  }

  public PVector getDestiny() {
    return this.destiny;
  }
}
