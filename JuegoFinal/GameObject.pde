/**Clase GameObject que heredaran los personajes y objetos del juego para su respectiva posicion*/
abstract class GameObject {
  /**El atributo posicion de heredacion para los objetos a dibujar*/
  protected PVector posicion;  
  
  /** Constructor por defecto */
  public GameObject() {
    posicion = new PVector(); 
  }
  
  /** Constructor parametrizado */
  public GameObject(float x, float y ) {
    posicion = new PVector(x, y); 
  }
  
  /**Método accesor de la posicion*/
  public PVector getPosicion() {
    return posicion;
  }
  
  /**Método de requerimiento para instanciar la posicion*/
  public void setPosicion(PVector posicion) {
    this.posicion = posicion;
  }
}
