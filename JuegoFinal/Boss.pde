class Boss extends GameObject {
  private PVector velocidad;
  private float angulo1, angulo2, angulo3, angulo4, angulo5, angulo6, angulo7, angulo8, angulo9, angulo10;
  private float escalar;
  private float radio;
  private PImage imagen;
  private float timer;
  ArrayList<Pelota> pelotas = new ArrayList<Pelota>();
  float a  = 0.1; // PARABOLA
  float b =0; //PARABOLA
  float c=0; //PARABOLA
  float drop = 8; //
  float cX, cX1; //

  public Boss(float x, float y) {
    this.position=new PVector(x, y);
    this.timer=0;
    this.velocidad = new PVector(100, 1);
    this.radio = 100;
    this.escalar = 40;
    this.imagen = loadImage("Images/boss.png");
    this.imagen.resize(150, 150);
  }
  public void display() {
    imageMode(CENTER);
    image(imagen, this.position.x, this.position.y);
    funcionCuadratica();
  }
  public void moveSinCos() {
    float ang1 = radians(angulo1);
    float ang2 = radians(angulo2);
    float ang3 = radians(angulo3);
    float ang4 = radians(angulo4);
    float ang5 = radians(angulo5);
    float ang6 = radians(angulo6);
    float ang7 = radians(angulo7);
    float ang8 = radians(angulo8);
    float ang9 = radians(angulo9);
    float ang10 = radians(angulo10);

    // Calculos de las nuevas posiciones x e y usando coseno y seno
    float x1 = this.position.x + (radio * cos(ang1));
    float y1 = this.position.y + (radio * sin(ang1));

    float x2 = this.position.x + (radio * cos(ang2));
    float y2 = this.position.y + (radio * sin(ang2));

    float x3 = this.position.x + (radio * cos(ang3));
    float y3 = this.position.y + (radio * sin(ang3));

    float x4 = this.position.x + (radio * cos(ang4));
    float y4 = this.position.y + (radio * sin(ang4));

    float x5 = this.position.x + (radio * cos(ang5));
    float y5 = this.position.y + (radio * sin(ang5));

    float x6 = this.position.x + (radio * cos(ang6));
    float y6 = this.position.y + (radio * sin(ang6));

    float x7 = this.position.x + (radio * cos(ang7));
    float y7 = this.position.y + (radio * sin(ang7));

    float x8 = this.position.x + (radio * cos(ang8));
    float y8 = this.position.y + (radio * sin(ang8));

    float x9 = this.position.x + (radio * cos(ang9));
    float y9 = this.position.y + (radio * sin(ang9));

    float x10 = this.position.x + (radio * cos(ang10));
    float y10 = this.position.y + (radio * sin(ang10));

    fill(#6F2586);
    ellipse(x1, y1, escalar / 2, escalar / 2); //  el primer círculo
    ellipse(x2, y2, escalar / 2, escalar / 2); //  el segundo círculo

    fill(#6F2586);
    ellipse(x3, y3, escalar / 2, escalar / 2); //  el tercer círculo
    ellipse(x4, y4, escalar / 2, escalar / 2); //  el cuarto círculo

    fill(#6F2586);
    ellipse(x5, y5, escalar / 2, escalar / 2); //  el quinto círculo
    ellipse(x6, y6, escalar / 2, escalar / 2); //  el sexto círculo

    fill(#6F2586);
    ellipse(x7, y7, escalar / 2, escalar / 2); //  el septimo círculo
    ellipse(x8, y8, escalar / 2, escalar / 2); //  el octavo círculo

    fill(#6F2586);
    ellipse(x9, y9, escalar / 2, escalar / 2); //  el noveno círculo
    ellipse(x10, y10, escalar / 2, escalar / 2); //  el decimo círculo

    // Incrementa los ángulos de forma uniforme
    angulo1 += 1;
    angulo2 += 2;
    angulo3 += 3;
    angulo4 += 4;
    angulo5 += 5;
    angulo6 += 6;
    angulo7 += 7;
    angulo8 += 8;
    angulo9 += 9;
    angulo10 += 10;

    // Mantener los ángulos dentro del rango de 0 a 360 grados
    if (angulo1 >= 360) angulo1 = 0;
    if (angulo2 >= 360) angulo2 = 0;
    if (angulo3 >= 360) angulo3 = 0;
    if (angulo4 >= 360) angulo4 = 0;
    if (angulo5 >= 360) angulo5 = 0;
    if (angulo6 >= 360) angulo6 = 0;
    if (angulo7 >= 360) angulo7 = 0;
    if (angulo8 >= 360) angulo8 = 0;
    if (angulo9 >= 360) angulo9 = 0;
    if (angulo10 >= 360) angulo10 = 0;
  }
  /**Metodo hecho para realizar los movimientos del jugador, mediante las direcciones en x e y.*/
  public void move() {
    this.timer += Time.getDeltaTime(frameRate);
    this.position.x+=this.velocidad.x * Time.getDeltaTime(frameRate);
    this.position.y+=5*(cos(this.timer * 2.0));
    teleport();
    //println(x, y);
  }
  public void funcionCuadratica() {
    if (frameCount % 60 == 10) { // Lanza una pelota cada segundo
      float velocidadInicial = random(-2,-4);
      for (float i = -width/2; i < width/2; i += 100) { // Ajusta el incremento para el número de pelotas
        float anguloLanzamiento = a * pow(i, 2) + b * i + c;
        PVector velocidad1 = new PVector(velocidadInicial, velocidadInicial);
        PVector velocidad2 = new PVector(-velocidadInicial, velocidadInicial);
        //pelota = new Pelota(new PVector(x+i, y+anguloLanzamiento), velocidad1);
        pelotas.add(new Pelota(new PVector(this.position.x + i, this.position.y + anguloLanzamiento), velocidad1));
        pelotas.add(new Pelota(new PVector(this.position.x + i, this.position.y + anguloLanzamiento), velocidad2));
      }
    }

    for (Pelota pelota : pelotas) {
      pelota.mover();
      pelota.display();
    }
    /**
    float posY = a *pow(cX, 2) + b * cX + c;

    float newCX = cX + this.position.x;
    float newCY = posY + this.position.y;
    float newCX1 = cX1 + this.position.x;
    fill(#6F2586);
    ellipse(newCX, newCY, 20, 20);
    fill(#6F2586);
    ellipse(newCX1, newCY, 20, 20);


    // Actualizar la posición x del objeto
    cX += drop;
    cX1 -= drop;
    if (posY > 500) {
      cX = 0; // Reiniciar a la izquierda si sale de la pantalla
      cX1 = 0;
    }*/
  }
  private void teleport() {
    if (this.position.x<-width) { // este condicion verifica si la posicion es menor al ancho para aparecer
      this.position.x=-width/2;
    } else if (this.position.x>900) {
      this.position.x=-width/2;
    }
    if (this.position.y<-width) {
      this.position.y=height;
    } else if (this.position.y>width) {
      this.position.y=0;
    }
  }
}
