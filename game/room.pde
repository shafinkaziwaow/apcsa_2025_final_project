class room {
  int width = 1536;
  int height = 864;
  private int w; // width of the room
  private int h; // height of the room
  public ArrayList<obstacle> obstacles; // coordinates of any obstacles in the room 
  public ArrayList<entity> enemies; // coordinates of any enemies in the room 
  
  public room(ArrayList<obstacle> obstacles, ArrayList<entity> enemies) {
    this.w = width / 10;
    this.h = height / 10;
    this.obstacles = obstacles;
    this.enemies = enemies;
  }
  
  public int getWidth() {
    return w;
  }
  
  public int getHeight() {
    return h;
  }
  
  public void setWidth(int w) {
    this.w = w;
  }
  
  public void setHeight(int h) {
    this.h = h;
  }
  
  public void placeObstacles() {
    for (obstacle ob : obstacles) {
      stroke(0);
      fill(0); 
      rect(ob.pos.x, ob.pos.y, ob.w, ob.h);
      //rect(width / 2, height / 2, 100, 100);
    }
  }
  
}
