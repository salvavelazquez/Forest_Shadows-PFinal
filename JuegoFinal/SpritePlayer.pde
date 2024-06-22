/**Clase SpritePlayer que se encarga de renderizar el sprite del protagonista en diferentes estados de movimiento*/
class SpritePlayer {
 /**Coordenada x del cuadro de imagen actual en el sprite de Samael*/
  protected int xFrame; 
  /**Coordenada y del cuadro de imagen actual en el sprite de Samael*/
  protected int yFrame; 
  protected PImage playerIdle;
  /**Imagen del sprite de Samael mirando a la izquierda*/
  protected PImage playerLeft; 
  /**Imagen del sprite de Samael mirando a la derecha*/
  protected PImage playerRight; 
   /**Ancho de cada cuadro de imagen en el sprite de Samael*/ 
  protected int widthFrame; 
  /**Alto de cada cuadro de imagen en el sprite de Samael*/
  protected int heightFrame; 
  /**Posición flotante del cuadro de imagen actual en la transición*/ 
  private float xFrameFloat; 
 /**Posición flotante del siguiente cuadro de imagen en la transición*/
  private float nextxFrameFloat; 
  /** Velocidad de transición entre los cuadros de imagen*/
  private float velTransicion; 

/**Constructor de la clase SpriteSamael,inicializa las variables y carga las imágenes del sprite de Samael*/

  public SpritePlayer() {
    this.playerIdle = requestImage("Images/reposo.png");
    //this.playerLeft = requestImage("enemy_left.png");
    //this.playerRight = requestImage("enemy_right.png");
    this.widthFrame = 128;
    this.heightFrame = 128;
    this.xFrame = 0;
    this.yFrame = 0;
    this.xFrameFloat = 0;
    this.nextxFrameFloat = widthFrame;
    this.velTransicion = 8;
  }

 /**Método para renderizar el sprite de Samael en función del estado y posición proporcionados*/

  public void renderPlayer(int state, PVector position,float camX) {
    imageMode(CENTER);
    switch (state) {
      case PlayerStateMachine.IDLE: {
        image(playerIdle.get(this.xFrame, this.yFrame, this.widthFrame, this.heightFrame),position.x-camX,position.y);
        xFrameFloat += (widthFrame * velTransicion * Time.getDeltaTime(frameRate));
        
        if (xFrameFloat >= nextxFrameFloat) {
          this.xFrame += this.widthFrame;
          nextxFrameFloat = xFrame + this.widthFrame;
          if (this.xFrame >= playerIdle.width) {
            this.xFrame = 0;
            this.xFrameFloat = 0;
            this.nextxFrameFloat = this.widthFrame;
          }
        }
        break;
      }
    }
  }
}
