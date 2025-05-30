class room {
  //int width = 1550;
  //int height = 875;
  int width = 900;
  int height = 700;
  public ArrayList<obstacle> obstacles; // coordinates of any obstacles in the room 
  public ArrayList<entity> enemies; // coordinates of any enemies in the room 
  
  public room () {
    this.obstacles = new ArrayList<obstacle>();
    this.enemies = new  ArrayList<entity>();
  }
  
  public room(ArrayList<obstacle> obstacles, ArrayList<entity> enemies) {
    this.obstacles = obstacles;
    this.enemies = enemies;
  }
  
  public void placeObstacles() {
    for (obstacle ob : obstacles) {
      stroke(0);
      fill(0); 
      rect(ob.pos.x, ob.pos.y, ob.w, ob.h);
      //rect(width / 2, height / 2, 100, 100);
    }
  }
  
  public void addObstacle(int w, int h, int x, int y, int c) {
    obstacle newObst = new obstacle(w, h, new PVector(x, y), c);
    obstacles.add(newObst);
  }
  
  public void placeEnemies() {
    for (entity e : enemies) {
      stroke(0);
      fill(255, 0, 0);
      rect(e.pos.x, e.pos.y, 50, 50);
      e.move(5);
    }
  }
  
  public void addEnemy(int x, int y, String name, int hp, int atk) {
    entity newEnemy = new entity(name, hp, atk, new PVector(x, y));
    enemies.add(newEnemy);
  }
  
  public void addEnemy(int x, int y) {
    entity newEnemy = new entity("basic enemy", 75, 25, new PVector(x, y));
    enemies.add(newEnemy);
  }
  
}
