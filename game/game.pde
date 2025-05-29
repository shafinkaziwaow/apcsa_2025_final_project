ArrayList<room> map = new ArrayList<room>();
ArrayList<room> map2 = new ArrayList<room>();
ArrayList<ArrayList<room>> fullMap = new ArrayList<ArrayList<room>>();
room currentRoom;
int currentRoomHindex = 0; // horizontal index
int currentRoomVindex = 0; // vertical index
room leftRoom = new room();
room centerRoom = new room();
room rightRoom = new room();
room righterRoom = new room();
room bottomLeftRoom = new room();
room bottomRightRoom = new room();
player hero = new player("hero", 1, 1, new PVector(width / 2, height / 2), new ArrayList<String>(), new ArrayList<Integer>());
int speed = 25;

void setup() {
  size(1550, 875);
  surface.setLocation(160, 90);
  
  map.add(leftRoom);
  map.add(centerRoom);
  map.add(rightRoom);
  map.add(righterRoom);
  fullMap.add(map);
  leftRoom.addObstacle(100, 100, 500, 200, 0);
  leftRoom.addObstacle(200, 200, 250, 500, 0);
  rightRoom.addObstacle(200, 300, 300, 300, 0);
  righterRoom.addObstacle(200, 150, 500, 600, 0);
  currentRoom = leftRoom;
  
  map2.add(bottomLeftRoom);
  map2.add(null);
  map2.add(bottomRightRoom);
  fullMap.add(map2);
  bottomLeftRoom.addObstacle(600, 400, 600, 400, 0);
  bottomRightRoom.addObstacle(350, 200, 900, 800, 0);
}

void draw() {
  load();
}

void load() {
  background(125);
  currentRoom.placeObstacles();
  fill(255);
  rect(hero.pos.x, hero.pos.y, 50, 50);
}

void keyPressed() {
  // movement 
  if (key == 's' && !hero.cannotGoes(currentRoom, 3)) {
    hero.pos.y += speed;
  }
  if (key == 'w' && !hero.cannotGoes(currentRoom, 1)) {
    hero.pos.y -= speed;
  }
  if (key == 'a' && !hero.cannotGoes(currentRoom, 4)) {
    hero.pos.x -= speed;
  }
  if (key == 'd' && !hero.cannotGoes(currentRoom, 2)) {
    hero.pos.x += speed;
  }
  
  // interaction (namely with borders for now)
  if (key == 'i') {
    
    if (hero.pos.x >= width - 50) { // going right 
      if (currentRoomHindex != fullMap.get(currentRoomVindex).size() -1 && fullMap.get(currentRoomVindex).get(currentRoomHindex + 1) != null) {
        currentRoomHindex++;
        hero.pos.x = 0;
      }
      currentRoom = fullMap.get(currentRoomVindex).get(currentRoomHindex);
    }
    
    else if (hero.pos.x <= 0 + 50) { // going left 
      if (currentRoomHindex != 0 && fullMap.get(currentRoomVindex).get(currentRoomHindex - 1) != null) {
        currentRoomHindex--;
        hero.pos.x = width - 50;
      }
      currentRoom = fullMap.get(currentRoomVindex).get(currentRoomHindex);
    }
    
    else if (hero.pos.y <= 0 + 50) { // going up
      if (currentRoomVindex != 0 && inBounds(-1) && fullMap.get(currentRoomVindex - 1).get(currentRoomHindex) != null) {
        currentRoomVindex--;
        hero.pos.y = height - 50;
      }
      currentRoom = fullMap.get(currentRoomVindex).get(currentRoomHindex);
    } 
    
    else if (hero.pos.y >= height - 50) { // going down
      if (currentRoomVindex != fullMap.size() - 1 && inBounds(1) && fullMap.get(currentRoomVindex + 1).get(currentRoomHindex) != null) {
      //if (currentRoomVindex != fullMap.size() - 1 && fullMap.get(currentRoomVindex + 1).get(currentRoomHindex) != null) {
        currentRoomVindex++;
        hero.pos.y = 0;
      }
      currentRoom = fullMap.get(currentRoomVindex).get(currentRoomHindex);
    }
    load();
  }
}

public boolean inBounds(int goingDown) { // account for ragged arrays
  return currentRoomHindex >= 0 && currentRoomHindex < fullMap.get(currentRoomVindex + goingDown).size();
}
