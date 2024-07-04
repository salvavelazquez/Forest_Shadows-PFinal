import processing.sound.*;
SoundFile file;
SoundFile jumping;
SoundFile gameOver;

Menu menu;
Game game;
/**Variable que usaremos para el estado a evaluar entre las pantallas*/
// ------ VARIABLE GLOBAL ------
int estadoActual;
int estadoMenu;

void setup() {
  fullScreen();
  frameRate(60); // Asegurar que el juego se ejecute a 60 fps
  menu = new Menu();
  game = new Game();
  estadoActual = StateMachine.MENU; // 0: Menu, 1: Game, 2: Instructions, 3: Developers
  estadoMenu = StateMachine.MENU; // 0: Menu, 1: Game, 2: Instructions, 3: Developers
  file = new SoundFile(this, "Sound/game-sound.wav");
  jumping = new SoundFile(this, "Sound/jump.wav");
  gameOver = new SoundFile(this, "Sound/game-over.wav");
  file.loop();
  file.amp(0.5);
}

void draw() {
  translate(width/2, height/2); // Establece el origen de coordenadas en el centro - PLANO CARTESIANO
  scale(1, 1); // Establece los cuadrantes
  switch(estadoActual) {
  case StateMachine.MENU:
    {
      menu.display();
      if (estadoMenu == StateMachine.INSTRUCTING) {
        menu.displayInstructions();
      } else if (estadoMenu == StateMachine.DEVS) {
        menu.displayDevelopers();
      }
      break;
    }
  case StateMachine.PLAYING:
    {
      game.display();
      break;
    }
  }
}

void mousePressed() {
  switch(estadoActual) {
  case StateMachine.MENU:
    {
      menu.mouseControladorMenu();
      menu.mouseControladorInstrucciones();
      menu.mouseControladorDesarrolladores();
      break;
    }
  }
}

void keyPressed() {
  switch(estadoActual) {
  case StateMachine.PLAYING:
    {
      game.tecladoControladorGame();
      break;
    }
  }
}

void keyReleased() {
  switch(estadoActual) {
  case StateMachine.PLAYING:
    {
      game.tecladoLiberadoGame();
      break;
    }
  }
}
