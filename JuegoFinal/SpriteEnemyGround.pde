class SpriteEnemyGround {
  protected int xFrame;
  protected int yFrame;
  protected PImage enemyLeft;
  protected PImage enemyRight;
  protected int widthFrame;
  protected int heightFrame;
  private float xFrameFloat;
  private float nextxFrameFloat;
  private float velTransition;
 
  // Añadir variables para el factor de escala
  private float scaleFactorX;
  private float scaleFactorY;

  public SpriteEnemyGround() {
    this.enemyLeft = requestImage("Images/enemyGroundLeft.png");
    this.enemyRight = requestImage("Images/enemyGroundRight.png");
    this.widthFrame = 520;
    this.heightFrame = 420;
    this.xFrame = 0;
    this.yFrame = 0;
    this.xFrameFloat = 0;
    this.nextxFrameFloat = widthFrame;
    this.velTransition = 10;

    // Inicializar los factores de escala
    this.scaleFactorX = 0.3; // Cambia este valor según sea necesario
    this.scaleFactorY = 0.3; // Cambia este valor según sea necesario
  }

  public void renderEnemyGround(int state, PVector position,float camX) {

     imageMode(CENTER);
    switch (state) {
      case EnemyGroundStateMachine.MOVE_LEFT:
        image(enemyLeft.get(this.xFrame, this.yFrame, this.widthFrame, this.heightFrame), 
              position.x - camX, position.y,
              this.widthFrame * this.scaleFactorX, 
              this.heightFrame * this.scaleFactorY);
        xFrameFloat += (widthFrame * velTransition * Time.getDeltaTime(frameRate));

        if (xFrameFloat >= nextxFrameFloat) {
          this.xFrame += this.widthFrame;
          nextxFrameFloat = xFrame + this.widthFrame;
          if (this.xFrame >= enemyLeft.width) {
            this.xFrame = 0;
            this.xFrameFloat = 0;
            this.nextxFrameFloat = this.widthFrame;
          }
        }
        break;

      case EnemyGroundStateMachine.MOVE_RIGHT:
        image(enemyRight.get(this.xFrame, this.yFrame, this.widthFrame, this.heightFrame), 
              position.x - camX, position.y,
              this.widthFrame * this.scaleFactorX, 
              this.heightFrame * this.scaleFactorY);
        xFrameFloat += (widthFrame * velTransition * Time.getDeltaTime(frameRate));

        if (xFrameFloat >= nextxFrameFloat) {
          this.xFrame += this.widthFrame;
          nextxFrameFloat = xFrame + this.widthFrame;
          if (this.xFrame >= enemyRight.width) {
            this.xFrame = 0;
            this.xFrameFloat = 0;
            this.nextxFrameFloat = this.widthFrame;
          }
        }
        break;
    }
  }
}
