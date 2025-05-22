class room {
  
  private int w; // width of the room
  private int h; // height of the room
  ArrayList<PVector> obstCoords; // coordinates of any obstacles in the room 
  ArrayList<entity> enemies; // coordinates of any enemies in the room 
  
  public room(ArrayList<PVector> obstCoords, ArrayList<entity> enemies) {
    this.w = width / 10;
    this.h = height / 10;
    this.obstCoords = obstCoords;
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
    for (PVector coord : obstCoords) {
      stroke(0);
      fill(0); 
      int hei = (int) random(40) + 10;
      int wid = (int) random(40) + 10;
      rect(coord.x, coord.y, hei, wid);
    }
  }
  
}
