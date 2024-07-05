class SpritePlayer {
  protected int xFrame;
  protected int yFrame;
  protected PImage playerIdle;
  protected PImage playerLeft;
  protected PImage playerRight;
  protected PImage playerGeneral;
  protected int widthFrame;
  protected int heightFrame;
  private float xFrameFloat;
  private float nextxFrameFloat;
  private float velTransition;

  // Añadir variables para el factor de escala
  private float scaleFactorX;
  private float scaleFactorY;

  public SpritePlayer() {
    this.playerIdle = requestImage("Images/reposo.png");
    this.playerLeft = requestImage("Images/izquierda.png");
    this.playerRight = requestImage("Images/derecha.png");
    this.widthFrame = 128;
    this.heightFrame = 128;
    this.xFrame = 0;
    this.yFrame = 0;
    this.xFrameFloat = 0;
    this.nextxFrameFloat = widthFrame;
    this.velTransition = 8;

    // Inicializar los factores de escala
    this.scaleFactorX = 1.5; // Cambia este valor según sea necesario
    this.scaleFactorY = 1.5; // Cambia este valor según sea necesario
  }

  public void renderPlayer(int state, PVector position, float camX) {

    switch (state) {
    case PlayerStateMachine.IDLE:
      playerGeneral = playerIdle;
      break;
    case PlayerStateMachine.MOVE_RIGHT:
      playerGeneral = playerRight;
      break;
    case PlayerStateMachine.MOVE_LEFT:
      playerGeneral = playerLeft;
      break;
      case PlayerStateMachine.JUMP:
    default:
      playerGeneral = playerIdle;
      break;
    }
    
    imageMode(CENTER);
    // Usar los factores de escala al renderizar la imagen
    image(playerGeneral.get(this.xFrame , this.yFrame , this.widthFrame , this.heightFrame),position.x - camX, position.y,
    this.widthFrame * this.scaleFactorX, 
    this.heightFrame * this.scaleFactorY);
    
    xFrameFloat += (widthFrame * velTransition * Time.getDeltaTime(frameRate));

    if (xFrameFloat >= nextxFrameFloat) {
      this.xFrame += this.widthFrame;
      nextxFrameFloat = xFrame + this.widthFrame;
      if (this.xFrame >= playerGeneral.width) {
        this.xFrame = 0;
        this.xFrameFloat = 0;
        this.nextxFrameFloat = this.widthFrame;
      }
    }
  }
}
