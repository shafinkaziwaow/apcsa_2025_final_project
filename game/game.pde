
ArrayList<room> map;
room currentRoom;
room centerRoom = new room(new ArrayList<obstacle>(), new ArrayList<entity>());
room rightRoom = new room(new ArrayList<obstacle>(), new ArrayList<entity>());
obstacle obst1 = new obstacle(100, 100, new PVector(500, 250), 0);
obstacle obst2 = new obstacle(200, 200, new PVector(250, 500), 0);
obstacle obst3 = new obstacle(200, 300, new PVector(300, 300), 50);
player hero = new player("hero", 1, 1, new PVector(width / 2, height / 2), new ArrayList<String>(), new ArrayList<Integer>());
int speed = 25;

void setup() {
  //size(1920, 1080);
  size(1536, 864);
  surface.setLocation(160, 90);
  //map.add(centerRoom);
  //map.add(rightRoom);
  centerRoom.obstacles.add(obst1);
  centerRoom.obstacles.add(obst2);
  //centerRoom.obstacles.add(obst3);
  rightRoom.obstacles.add(obst3);
  currentRoom = centerRoom;
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
    if (hero.pos.x >= width - 50) {
        currentRoom = rightRoom;
    }
    if (hero.pos.x <= 0 + 50) {
      currentRoom = centerRoom;
    }
    load();
  }
}
