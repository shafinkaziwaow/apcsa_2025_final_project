class room {
  int width = 1550;
  int height = 875;
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
  
}
