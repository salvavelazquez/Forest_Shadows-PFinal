Menu menu;
Game game;
int estadoActual;
Player player;

void setup() {
  size(1200, 600);
  frameRate(60); // Asegurar que el juego se ejecute a 60 fps
  menu = new Menu();
  game = new Game();
  estadoActual = 0; // 0: Menu, 1: Game, 2: Instructions, 3: Developers
}

void draw() {
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
    //game.tecladoLiberadoGame();
  }
}
