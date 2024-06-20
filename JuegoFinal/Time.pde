/**Clase estatica Time que funciona como metodo globAl para establecer el deltaTime*/
static class Time{
  static float getDeltaTime(float frames){
    int framesPorSegundo = round(frames);
    float deltaTime = 1.0/framesPorSegundo;
    return deltaTime;
  }
}
