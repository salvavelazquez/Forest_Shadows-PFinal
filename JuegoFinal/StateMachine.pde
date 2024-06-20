/**Se establece la clase de estados que usaremos como flujo de las interfaces de la pantalla*/
class StateMachine{
  /**Se da inicio a la pantalla de inicio*/
  public static final int START = 1;
  /**El atributo jugando da el estado para cambiar de pantalla al nivel*/
  public static final int PLAYING = 2;
  /**Cambia la estado de victoria en la partida*/  
  public static final int WINING = 3;
  /**Cambia la estado de fracaso en la partida*/
  public static final int LOSING = 4;
}
