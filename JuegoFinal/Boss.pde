class Boss extends GameObject {
  private PVector velocidad;
  private PImage imagen;
  private float timer;
  private float lastLaunchFrame; // Temporizador para controlar el intervalo entre lanzamientos
  private float startLaunchFrame; // Temporizador para el inicio del lanzamiento
  private ArrayList<Pelota> pelotas;
  private ArrayList<Egg> eggs;
  private float radio;
  private int numPelotas;
  private float anguloInicial;
  private float a = 0.1; // Parábola
  private float b = 0; // Parábola
  private float c = 0; // Parábola
  private int maxEnemies = 7; // Máximo número de enemigos permitidos
  private ArrayList<Enemy> enemies1; // Declarar la lista de enemigos
  private ArrayList<Platform> platforms;

  public Boss(float x, float y, ArrayList<Enemy> enemies1, ArrayList<Platform> platforms) {
    this.position = new PVector(x, y);
    this.timer = 0;
    this.lastLaunchFrame = 0; // Inicializar el temporizador
    this.startLaunchFrame = 300; // El boss comenzará a lanzar huevos después de este tiempo (frames)
    this.velocidad = new PVector(100, 1);
    this.radio = 100;
    this.numPelotas = 7; // Número inicial de pelotas
    this.anguloInicial = 0;
    this.pelotas = new ArrayList<Pelota>();
    this.eggs = new ArrayList<Egg>();
    this.imagen = loadImage("Images/boss.png");
    this.imagen.resize(150, 150);
    this.enemies1 = enemies1;
    this.platforms = platforms;
    crearPelotas(); // Crear pelotas alrededor del Boss
  }

  public void display(float camX) {
    verificarColisiones(camX);

    image(imagen, this.position.x, this.position.y);
    for (Pelota pelota : pelotas) {
      pelota.display();
    }
    actualizarPelotas(); // Actualizar posiciones de las pelotas
    if (frameCount > startLaunchFrame) { // Determina si pasaron tantos framess
      lanzarEggs();
      eliminarEnemigosFueraDeLimite();
    }
  }


  public void move() {
    this.timer += Time.getDeltaTime(frameRate);
    this.position.x += this.velocidad.x * Time.getDeltaTime(frameRate);
    this.position.y += 5 * cos(this.timer * 2.0);
    teleport();
  }

  private void crearPelotas() {
    pelotas.clear();
    for (int i = 0; i < numPelotas; i++) {
      float angulo = anguloInicial + TWO_PI / numPelotas * i;
      float x = this.position.x + cos(angulo) * radio;
      float y = this.position.y + sin(angulo) * radio;
      pelotas.add(new Pelota(x, y, 30, angulo, 0.03));
    }
  }

  private void actualizarPelotas() {
    float anguloDelta = 0.05;
    for (int i = 0; i < pelotas.size(); i++) {
      Pelota pelota = pelotas.get(i);
      float angulo = anguloInicial + TWO_PI / numPelotas * i;
      pelota.pos.x = this.position.x + cos(angulo + anguloDelta * frameCount) * radio;
      pelota.pos.y = this.position.y + sin(angulo + anguloDelta * frameCount) * radio;
    }
  }

  private void lanzarEggs() {
    if ((frameCount - lastLaunchFrame) > 120 &&  enemies1.size() < maxEnemies) { // Lanza un huevo cada segundo si hay pelotas disponibles
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
      egg.mover();
      egg.handleCollision(platforms); // Verifica colisiones con plataformas
      egg.display();
    }
  }

  private void teleport() {
    if (this.position.x < -width) {
      this.position.x = -width / 2;
      maxEnemies = 7; // Reiniciar el límite de enemigos al teletransportarse
    } else if (this.position.x > 900) {
      crearPelotas();
      this.position.x = -width / 2;
      maxEnemies = 7; // Reiniciar el límite de enemigos al teletransportarse
    }
    if (this.position.y < -width) {
      this.position.y = height;
    } else if (this.position.y > width) {
      this.position.y = 0;
    }
  }

  private void eliminarEnemigosFueraDeLimite() {
    for (int i = enemies1.size() - 1; i >= 0; i--) {
      Enemy enemy = enemies1.get(i);
      if (enemy.position.y > 600) { // Verificar si el enemigo pasa el límite
        enemies1.remove(i); // Eliminar enemigo de la lista
      }
    }
  }


  private void verificarColisiones(float camX) {
    for (int i = eggs.size() - 1; i >= 0; i--) {
      Egg egg = eggs.get(i);
      if (!egg.isFalling) { // Verificar si el huevo ha dejado de caer (ha colisionado con una plataforma)
        if (enemies1.size() < maxEnemies) {
          boolean enemyExists = false;
          for (Enemy enemy : enemies1) {
            if (dist(enemy.position.x, enemy.position.y, egg.posicion.x, egg.posicion.y) < 1) {
              enemyExists = true;
              break;
            }
          }
          if (!enemyExists ) {
            enemies1.add(new Enemy(egg.posicion.x + camX, egg.posicion.y, random(3, 5))); // Crear enemigo en la posición exacta del huevo
          }
        }
        eggs.remove(i); // Remover huevo de la lista
      }
    }
  }
}
