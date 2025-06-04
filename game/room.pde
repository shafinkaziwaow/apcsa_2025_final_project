class room {
  //int width = 1550;
  //int height = 875;
  int width = 900;
  int height = 700;
  public ArrayList<obstacle> obstacles; // coordinates of any obstacles in the room 
  public ArrayList<enemy> enemies; // coordinates of any enemies in the room 
  player p;
  
  public room () {
    this.obstacles = new ArrayList<obstacle>();
    this.enemies = new  ArrayList<enemy>();
  }
  
  public room(ArrayList<obstacle> obstacles, ArrayList<enemy> enemies) {
    this.obstacles = obstacles;
    this.enemies = enemies;
  }
  
  public void placeObstacles() {
    for (obstacle ob : obstacles) {
      stroke(0);
      fill(0); 
      rect(ob.pos.x, ob.pos.y, ob.w, ob.h);
    }
  }
  
  public void addObstacle(int w, int h, int x, int y, color c) {
    obstacle newObst = new obstacle(w, h, new PVector(x, y), c);
    obstacles.add(newObst);
  }
  
  public void addObstacle(color c) {
    obstacle newObst = new obstacle(c);
    obstacles.add(newObst);
  }
  
  public void placeEnemies() {
    for (enemy e : enemies) {
      stroke(0);
      fill(255, 0, 0);
      rect(e.pos.x, e.pos.y, 50, 50);
      if (e.cannotGoes(this, e.dir)) {
        e.newDir(p, this);
      } else { 
        if (e.inRange(p, e.range)) {
          if (e.atkCoolDown > 0) {
            e.atkCoolDown--;
          } else {
            e.attack(p);
            e.atkCoolDown = 100;
          }
        } else {
          if (e.moveCoolDown == 0) {
            if (!e.cannotGoes(this, e.dir)) {
              e.move(p, this);
            } else {
              e.newDir(p, this);
            }
            e.moveCoolDown = 10;
          }
            
            else {
            e.moveCoolDown--;
          }
        }
      }
    }
  }
  
  public void addEnemy(int x, int y, String name, int hp, int atk, int dir) {
    enemy newEnemy = new enemy(name, hp, hp, atk, new PVector(x, y), dir, 50, 30);
    enemies.add(newEnemy);
  }
  
  public void addEnemy(int x, int y) {
    enemy newEnemy = new enemy("enemy", 75, 75, 50, new PVector(x, y), 3, 50, 30);
    enemies.add(newEnemy);
  }
  
}
