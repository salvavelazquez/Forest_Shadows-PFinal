import processing.sound.*;
SoundFile file;
SoundFile jumping;
SoundFile gameOver;
SoundFile win;

Menu menu;
Game game;
/**Variable que usaremos para el estado a evaluar entre las pantallas*/
// ------ VARIABLE GLOBAL ------
int currentState;
int menuState;

void setup() {
  fullScreen();
  frameRate(60); // Asegurar que el juego se ejecute a 60 fps
  menu = new Menu();
  game = new Game();
  currentState = StateMachine.MENU; // 0: Menu, 1: Game, 2: Instructions, 3: Developers
  menuState = StateMachine.MENU; // 0: Menu, 1: Game, 2: Instructions, 3: Developers
  file = new SoundFile(this, "Sound/game-sound.wav");
  jumping = new SoundFile(this, "Sound/jump.wav");
  gameOver = new SoundFile(this, "Sound/game-over.wav");
  win = new SoundFile(this, "Sound/win.wav");
  file.loop();
  file.amp(0.5);
}

void draw() {
  translate(width/2, height/2); // Establece el origen de coordenadas en el centro - PLANO CARTESIANO
  scale(1, 1); // Establece los cuadrantes
  switch(currentState) {
  case StateMachine.MENU:
    {
      menu.display();
      if (menuState == StateMachine.INSTRUCTING) {
        menu.displayInstructions();
      } else if (menuState == StateMachine.DEVS) {
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
  switch(currentState) {
  case StateMachine.MENU:
    {
      menu.mouseControllerMenu();
      menu.mouseControllerInstructions();
      menu.mouseControllerDevs();
      break;
    }
  }
}

void keyPressed() {
  switch(currentState) {
  case StateMachine.PLAYING:
    {
      game.keyControllerGame();
      break;
    }
  }
}

void keyReleased() {
  switch(currentState) {
  case StateMachine.PLAYING:
    {
      game.releasedKeyGame();
      break;
    }
  }
}
