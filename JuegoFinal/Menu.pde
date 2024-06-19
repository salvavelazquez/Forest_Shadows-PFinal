class Menu {
  PImage backgroundImage;
  Button playButton;
  Button instructionsButton;
  Button developersButton;
  Button backButton ;
  float y;

  Menu() {
    backgroundImage = loadImage("Images/fondo3.jpg");
    playButton = new Button(width / 2 - 100, height / 2, 200, 50, "Play");
    instructionsButton = new Button(width / 2 - 100, height / 2 + 60, 200, 50, "Instrucciones");
    developersButton = new Button(width / 2 - 100, height / 2 + 120, 200, 50, "Desarrolladores");
    backButton = new Button(width / 2 - 100, height / 2 + 160, 220, 50, "Regresar al menú");
  }
  
  void display() {
    image(backgroundImage, 0, 0, width, height);
    fill(255);
    textSize(80);
    textAlign(CENTER);
    textFont(createFont("Arial Bold", 80)); 
    text("The Game", width / 2, height / 3);
    playButton.display();
    instructionsButton.display();
    developersButton.display();
  }

  void displayInstructions() {
    image(backgroundImage, 0, 0, width, height);
    fill(255);
    textSize(24);
    textAlign(CENTER);
    text("Usa las teclas A y D para moverte y la tecla W para saltar.", width / 2, height / 2);
    backButton.display();
    
  }
  
  void displayDevelopers() {
    image(backgroundImage, 0, 0, width, height);
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("DEVELOPERS", width / 2, y);
    text("- Alejandro Mercado", width / 2, y + 40);
    text("- Leonardo Guanuco", width / 2, y + 80);
    text("- Augusto Velazquez", width / 2, y + 120);
    y -= 15;
    if (y < height / 2 - 60) {
      y = height / 2 - 60; // Para detener texto en el mdio
    }
    backButton.display();
  }
  
  void mouseControladorMenu() {
    if (playButton.mouseEstaEncima()) {
      estadoActual = 1;
    } else if (instructionsButton.mouseEstaEncima()) {
      estadoActual = 2;
    }else if (developersButton.mouseEstaEncima()) {
      estadoActual = 3;
      y = height; // Resetear
    } else if (backButton.mouseEstaEncima()) {
      estadoActual = 0;
    }
  }
  
  void mouseControladorInstrucciones() {
    if (backButton.mouseEstaEncima()) {
      estadoActual = 0;
    }
  }
  
  void mouseControladorDesarrolladores() {
    if (backButton.mouseEstaEncima()) {
      estadoActual = 0;
    }
  }

}
