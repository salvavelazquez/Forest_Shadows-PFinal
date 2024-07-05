class Boss extends GameObject {
  private PVector speed;
  private PImage sprite;
  private float timer;
  private float lastLaunchFrame; // Temporizador para controlar el intervalo entre lanzamientos
  private float startLaunchFrame; // Temporizador para el inicio del lanzamiento
  private ArrayList<PowerBoss> powerBoss;
  private ArrayList<Egg> eggs;
  private float radius;
  private int numPowers;
  private float initialAngle;
  private float a = 0.1; // Parábola
  private float b = 0; // Parábola
  private float c = 0; // Parábola
  private int maxEnemies = 7; // Máximo número de enemigos permitidos
  //private ArrayList<Enemy> enemies1; // Declarar la lista de enemigos
  private ArrayList<Platform> platforms;
  private Game game;

  public Boss(float x, float y, ArrayList<Platform> platforms, Game game) {
    this.position = new PVector(x, y);
    this.timer = 0;
    this.lastLaunchFrame = 0; // Inicializar el temporizador
    this.startLaunchFrame = 300; // El boss comenzará a lanzar huevos después de este tiempo (frames)
    this.speed = new PVector(100, 1);
    this.radius = 100;
    this.numPowers = 7; // Número inicial de pelotas
    this.initialAngle = 0;
    this.powerBoss = new ArrayList<PowerBoss>();
    this.eggs = new ArrayList<Egg>();
    this.sprite = loadImage("Images/boss.png");
    this.sprite.resize(150, 150);
    this.platforms = platforms;
    createPower(); // Crear pelotas alrededor del Boss
    this.game = game; // Establecer referencia al juego
  }

  public void display(float camX) {

    image(sprite, this.position.x, this.position.y);
    for (PowerBoss powers : powerBoss) {
      powers.display();
    }
    updatePower(); // Actualizar posiciones de las pelotas
    if (frameCount > startLaunchFrame) { // Determina si pasaron tantos frames
      throwEggs(camX); // Lanza los huevos
    }
    checkCollisions(camX);
  }


  public void move() {
    this.timer += Time.getDeltaTime(frameRate);
    this.position.x += this.speed.x * Time.getDeltaTime(frameRate);
    this.position.y += 5 * cos(this.timer * 2.0);
    teleport();
  }

  private void createPower() {
    powerBoss.clear();
    for (int i = 0; i < numPowers; i++) {
      float angulo = initialAngle + TWO_PI / numPowers * i;
      float x = this.position.x + cos(angulo) * radius;
      float y = this.position.y + sin(angulo) * radius;
      powerBoss.add(new PowerBoss(x, y, 30, angulo, 0.03));
    }
  }

  private void updatePower() {
    float anguloDelta = 0.05;
    for (int i = 0; i < powerBoss.size(); i++) {
      PowerBoss powers = powerBoss.get(i);
      float angulo = initialAngle + TWO_PI / numPowers * i;
      float newPositionX = this.position.x + cos(angulo + anguloDelta * frameCount) * radius;
      float newPositionY = this.position.y + sin(angulo + anguloDelta * frameCount) * radius;
      powers.setPosition(new PVector(newPositionX, newPositionY));
    }
  }

  private void throwEggs(float camX) {
    if (powerBoss.size() > 0 &&(frameCount - lastLaunchFrame) > 120) { // Lanza un huevo cada segundo si hay pelotas disponibles
      PowerBoss powers = powerBoss.size() > 0 ? powerBoss.remove(0) : null; // Remueve la primera pelota del ArrayList si existe
      PowerBoss powers1 = powerBoss.size() > 0 ? powerBoss.remove(0) : null;
      float velocidadInicial = random(-2, -4);
      float anguloLanzamiento = a * pow(0, 2) + b * 0 + c;
      PVector velocidad1 = new PVector(velocidadInicial, velocidadInicial);
      PVector velocidad2 = new PVector(-velocidadInicial, velocidadInicial);
      eggs.add(new Egg(new PVector(this.position.x, this.position.y + anguloLanzamiento), velocidad1));
      eggs.add(new Egg(new PVector(this.position.x, this.position.y + anguloLanzamiento), velocidad2));
      lastLaunchFrame = frameCount; // Reiniciar el contador de frames
    }


    for (int i = eggs.size() - 1; i >= 0; i--) {
      Egg egg = eggs.get(i);
      egg.move();
      egg.handleCollision(platforms, camX);
      egg.display();
    }
  }

  private void teleport() {
    if (this.position.x < -width) {
      this.position.x = -width / 2;
      maxEnemies = 7; // Reiniciar el límite de enemigos al teletransportarse
    } else if (this.position.x > 900) {
      createPower();
      this.position.x = -width / 2;
      maxEnemies = 7; // Reiniciar el límite de enemigos al teletransportarse
    }
    if (this.position.y < -width) {
      this.position.y = height;
    } else if (this.position.y > width) {
      this.position.y = 0;
    }
  }

  private void checkCollisions(float camX) {
    for (int i = eggs.size() - 1; i >= 0; i--) {
      Egg egg = eggs.get(i);

      if (!egg.isFalling && egg.isOnPlatform()) {
        PVector newPositionEnemy = new PVector(egg.getPosicion().x+camX, egg.getPosicion().y-60);

        game.activateEnemy(newPositionEnemy);
        eggs.remove(i);
      }
    }
  }
}
