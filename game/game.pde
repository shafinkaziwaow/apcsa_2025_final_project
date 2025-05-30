ArrayList<room> map = new ArrayList<room>();
ArrayList<room> map2 = new ArrayList<room>();
ArrayList<ArrayList<room>> fullMap = new ArrayList<ArrayList<room>>();
room currentRoom;
int currentRoomHindex = 1; // horizontal index
int currentRoomVindex = 0; // vertical index
room levelOneL = new room();
room levelOneC = new room();
room levelOneR = new room();
room levelTwoL = new room();
room levelTwoC = new room();
room levelTwoR = new room();
player hero = new player("hero", 1, 1, new PVector(width / 2, height / 2), new ArrayList<String>(), new ArrayList<Integer>());
int speed = 25;

void setup() {
  //size(1550, 875);
  size(900, 700);
  surface.setLocation(160, 90);
  
  map.add(levelOneL);
  map.add(levelOneC);
  map.add(levelOneR);
  fullMap.add(map);
  levelOneL.addObstacle(100, 100, 500, 200, 0);
  levelOneL.addObstacle(200, 200, 250, 500, 0);
  levelOneR.addObstacle(200, 300, 300, 300, 0);
  levelOneR.addEnemy(650, 100);
  currentRoom = levelOneC;
  
  map2.add(levelTwoL);
  map2.add(levelTwoC);
  map2.add(levelTwoR);
  fullMap.add(map2);
  levelTwoL.addObstacle(600, 400, 600, 400, 0);
  levelTwoC.addObstacle(350, 200, 900, 800, 0);
}

void draw() {
  load();
}

void load() {
  background(125);
  currentRoom.placeObstacles();
  currentRoom.placeEnemies();
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
    
    //else if (hero.pos.y <= 0 + 50) { // going up
    //  if (currentRoomVindex != 0 && fullMap.get(currentRoomVindex - 1).get(currentRoomHindex) != null) {
    //    currentRoomVindex--;
    //    hero.pos.y = height - 50;
    //  }
    //  currentRoom = fullMap.get(currentRoomVindex).get(currentRoomHindex);
    //} 
    
    else if (hero.pos.y >= height - 50) { // going down
      if (currentRoomVindex != fullMap.size() - 1 && fullMap.get(currentRoomVindex + 1).get(currentRoomHindex) != null) {
      //if (currentRoomVindex != fullMap.size() - 1 && fullMap.get(currentRoomVindex + 1).get(currentRoomHindex) != null) {
        currentRoomVindex++;
        hero.pos.y = 0;
      }
      currentRoom = fullMap.get(currentRoomVindex).get(currentRoomHindex);
    }
    load();
  }
}
