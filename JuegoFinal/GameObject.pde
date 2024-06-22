/**Clase GameObject que heredaran los personajes y objetos del juego para su respectiva posicion*/
abstract class GameObject {
  /**El atributo posicion de heredacion para los objetos a dibujar*/
  protected PVector position;  
  
  /** Constructor por defecto */
  public GameObject() {
    position = new PVector(); 
  }
  
  /** Constructor parametrizado */
  public GameObject(float x, float y ) {
    position = new PVector(x, y); 
  }
  
  /**Método accesor de la posicion*/
  public PVector getPosition() {
    return position;
  }
  
  /**Método de requerimiento para instanciar la posicion*/
  public void setPosition(PVector position) {
    this.position = position;
  }
}
