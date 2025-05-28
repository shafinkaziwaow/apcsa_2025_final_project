ArrayList<room> map = new ArrayList<room>();
ArrayList<room> map2 = new ArrayList<room>();
ArrayList<ArrayList<room>> fullMap = new ArrayList<ArrayList<room>>();
room currentRoom;
int currentRoomHindex = 0; // horizontal index
int currentRoomVindex = 0; // vertical index
room centerRoom = new room(new ArrayList<obstacle>(), new ArrayList<entity>());
room rightRoom = new room(new ArrayList<obstacle>(), new ArrayList<entity>());
room bottomRightRoom = new room(new ArrayList<obstacle>(), new ArrayList<entity>());
obstacle obst1 = new obstacle(100, 100, new PVector(500, 250), 0);
obstacle obst2 = new obstacle(200, 200, new PVector(250, 500), 0);
obstacle obst3 = new obstacle(200, 300, new PVector(300, 300), 50);
obstacle obst4 = new obstacle(600, 400, new PVector(600, 400), 255);
player hero = new player("hero", 1, 1, new PVector(width / 2, height / 2), new ArrayList<String>(), new ArrayList<Integer>());
int speed = 25;

void setup() {
  size(1550, 875);
  surface.setLocation(160, 90);
  
  map.add(centerRoom);
  map.add(rightRoom);
  fullMap.add(map);
  centerRoom.obstacles.add(obst1);
  centerRoom.obstacles.add(obst2);
  rightRoom.obstacles.add(obst3);
  currentRoom = centerRoom;
  
  map2.add(bottomRightRoom);
  //map2.add(null);
  fullMap.add(map2);
  bottomRightRoom.obstacles.add(obst4);
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
  
  if (key == 'i') {
    
    if (hero.pos.x >= width - 50) { // going right 
      if (currentRoomHindex != fullMap.get(currentRoomVindex).size() -1) {
        currentRoomHindex++;
        hero.pos.x = 0;
      }
      currentRoom = fullMap.get(currentRoomVindex).get(currentRoomHindex);
    }
    
    else if (hero.pos.x <= 0 + 50) { // going left 
      if (currentRoomHindex != 0) {
        currentRoomHindex--;
        hero.pos.x = width - 50;
      }
      currentRoom = fullMap.get(currentRoomVindex).get(currentRoomHindex);
    }
    
    else if (hero.pos.y <= 0 + 50) { // going up
      if (currentRoomVindex != 0) {
        currentRoomVindex--;
        hero.pos.y = height - 50;
      }
      currentRoom = fullMap.get(currentRoomVindex).get(currentRoomHindex);
    } 
    
    else if (hero.pos.y >= height - 50) { // going down
      if (currentRoomVindex != fullMap.size() - 1 && currentRoomHindex >= 0 && currentRoomHindex < fullMap.get(currentRoomVindex + 1).size()) {
        currentRoomVindex++;
        hero.pos.y = 0;
      }
      currentRoom = fullMap.get(currentRoomVindex).get(currentRoomHindex);
    }
    load();
  }
}
