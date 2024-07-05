class Menu {
  private PImage backgroundImage;
  private float up;
  private Button playButton;
  private Button instructionsButton;
  private Button developersButton;
  private Button backButton ;

  public Menu() {
    this.backgroundImage = loadImage("Images/backgroundMenu2.jpg");
    this.playButton = new Button(500, height / 2 - 70, 360, 60, "Play");
    this.instructionsButton = new Button(500, height / 2 +5 , 360, 60, "Instrucciones");
    this.developersButton = new Button(500, height / 2 + 80, 360, 60, "Desarrolladores");
    this.backButton = new Button(width-320, height-115 , 220, 70, "Regresar");
  }
  
  public void display() {
    pushMatrix(); // Mantiene las posiciones anteriores al cambio en el translate y scale en void draw
    resetMatrix(); // Mantiene las posiciones anteriores al cambio en el translate y scale en void draw
    image(this.backgroundImage, 0, 0, width, height);
    fill(255);
    textSize(80);
    textAlign(CENTER);
    textFont(createFont("Arial Bold", 80)); 
    text("Forest Shadows", width / 2, height / 4);
    playButton.display();
    instructionsButton.display();
    developersButton.display();
    popMatrix(); // Mantiene las posiciones anteriores al cambio en el translate y scale en void draw
  }

  public void displayInstructions() {
    pushMatrix();
    resetMatrix();
    image(this.backgroundImage, 0, 0, width, height);
    fill(255);
    textSize(30);
    textAlign(LEFT);
    text("Instrucciones:\n" +
         "\n"+
         "Usa las teclas A y D o la flecha izquierda y derecha para moverte.\n" +
         "\n"+
         "Usa la tecla W o la flecha hacia arriba para saltar.\n" +
         "\n"+
         "Presiona la barra espaciadora más una tecla de movimiento para \nactivar el poder de visión.", 230, 300);
    backButton.display();
    popMatrix();    
  }
  
  public void displayDevelopers() {
    pushMatrix();
    resetMatrix();
    image(this.backgroundImage, 0, 0, width, height);
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text(" DEVELOPERS", width / 2, this.up);
    text("-> Alejandro Mercado", width / 2, this.up + 70);
    text("-> Leonardo Guanuco", width / 2, this.up + 130);
    text("-> Augusto Velazquez", width / 2, this.up + 190);
    this.up -= 100 * Time.getDeltaTime(frameRate);
    if (this.up < height / 2 - 90) {
      this.up = height / 2 - 90; // Para detener texto en el mdio
    }
    backButton.display();
    popMatrix();    
  }
  
  public void mouseControllerMenu() {
    if (playButton.mouseOnTop()) {
      currentState = StateMachine.PLAYING;
    } else if (instructionsButton.mouseOnTop()) {
      menuState = StateMachine.INSTRUCTING;
    }else if (developersButton.mouseOnTop()) {
      menuState = StateMachine.DEVS;;
      this.up = height; // Resetear
    } else if (backButton.mouseOnTop()) {
      menuState = StateMachine.MENU;
    }
  }
  
  public void mouseControllerInstructions() {
    if (backButton.mouseOnTop()) {
      menuState = StateMachine.MENU;
    }
  }
  
  public void mouseControllerDevs() {
    if (backButton.mouseOnTop()) {
      menuState = StateMachine.MENU;
    }
  }

}
