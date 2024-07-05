class PowerBoss extends GameObject{
  private float diameter;
  public float angle;
  public float angleSpeed;
  
  public PowerBoss(float x, float y, float diam, float angle, float angleSpeed) {
    this.position = new PVector(x, y);
    this.diameter = diam;
    this.angle = angle;
    this.angleSpeed = angleSpeed;
  }

  public void display() {
    ellipse(this.position.x, this.position.y, diameter, diameter);
  }
}
