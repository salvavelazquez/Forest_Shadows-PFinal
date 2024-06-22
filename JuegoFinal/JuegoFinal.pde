Menu menu;
Game game;
/**Variable que usaremos para el estado a evaluar entre las pantallas*/
// ------ VARIABLE GLOBAL ------
int estadoActual;
//**Variable para indicar si se debe reiniciar el nivel*/
boolean reiniciarNivel = false;

void setup() {
  fullScreen();
  frameRate(60); // Asegurar que el juego se ejecute a 60 fps
  menu = new Menu();
  game = new Game();
  estadoActual = 1; // 0: Menu, 1: Game, 2: Instructions, 3: Developers
}

void draw() {
  translate(width/2,height/2); // Establece el origen de coordenadas en el centro - PLANO CARTESIANO
  scale(1,1); // Establece los cuadrantes
  background(0);

  if (estadoActual == 0) {
    menu.display();
  } else if (estadoActual == 1) {
    game.display();
  } else if (estadoActual == 2) {
    menu.displayInstructions();
  } else if (estadoActual == 3) {
    menu.displayDevelopers();
  }
}

void mousePressed() {
  if (estadoActual == 0) {
    menu.mouseControladorMenu();
  } else if (estadoActual == 1) {
    game.mouseControladorGame();
  } else if (estadoActual == 2) {
    menu.mouseControladorInstrucciones();
  } else if (estadoActual == 3) {
    menu.mouseControladorDesarrolladores();
  }
}

void keyPressed() {
  if (estadoActual == 1) {
    game.tecladoControladorGame();
  } else if (estadoActual == 2 ) {
    estadoActual = 0;
  } else if (estadoActual == 3) {
    estadoActual = 0;
  }
}

void keyReleased() {
  if (estadoActual == 1) {
    game.tecladoLiberadoGame();
  }
}
