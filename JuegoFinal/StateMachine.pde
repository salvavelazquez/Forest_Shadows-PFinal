/**Se establece la clase de estados que usaremos como flujo de las interfaces de la pantalla*/
class StateMachine{
  /**Se da inicio a la pantalla de inicio*/
  public static final int MENU = 1;
  public static final int INSTRUCTING = 2;
  public static final int DEVS = 3;
  /**El atributo jugando da el estado para cambiar de pantalla al nivel*/
  public static final int PLAYING = 4;
  /**Cambia la estado de victoria en la partida*/  
  public static final int WINING = 5;
  /**Cambia la estado de fracaso en la partida*/
  public static final int LOSING = 6;
}
