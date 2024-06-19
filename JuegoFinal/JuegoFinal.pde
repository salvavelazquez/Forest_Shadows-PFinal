ArrayList<Level> levels;
Player player;
int currentLevel;


void setup() {
  size(1200, 600);

  player = new Player(new PVector(100, height - 60), "Images/player.png");
  ArrayList<Enemy> enemy = new ArrayList<Enemy>();
  enemy.add(new Enemy(new PVector(300, height - 60), 2,"Images/Enemies/enemy.png"));

  levels = new ArrayList<Level>();
  levels.add(new Level(enemy, "Images/levels/background1.jpg"));
  currentLevel = 0;
}

void draw() {
  Level level = levels.get(currentLevel);
  level.display();
  player.display();
  player.update();
}
