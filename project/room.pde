class Room {
  
  private int w; // width of the room
  private int h; // height of the room
  private ArrayList<PVector> obstCoords; // coordinates of any obstacles in the room 
  private ArrayList<PVector> enemyCoords; // coordinates of any enemies in the room 
  
  public Room(int w, int h, ArrayList<PVector> obstCoords, ArrayList<PVector> enemyCoords) {
    this.w = width / 10;
    this.h = height / 10;
    this.obstCoords = obstCoords;
    this.enemyCoords = enemyCoords;
  }
  
  public void placeEnemies() {
    for (PVector coord : enemyCoords) {
      // probably will have an enemy class 
      // create an enemy object and place them at coord.x, coord.y 
    }
  }
  
  public void placeObstacles() {
    for (PVector coord : obstCoords) {
      stroke(0);
      fill(0); 
      int hei = random(40) + 10;
      int wid = random(40) + 10;
      rect(coord.x, coord.y, hei, wid);
    }
  }
  
}
