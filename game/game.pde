
ArrayList<room> map;
room centerRoom = new room(new ArrayList<obstacle>(), new ArrayList<entity>());
obstacle obst1 = new obstacle(new PVector(500, 500), 0);
//obstacle obst2 = new obstacle(0);
//obstacle obst3 = new obstacle(0);
player hero = new player("hero", 1, 1, new PVector(width / 2, height / 2), new ArrayList<String>(), new ArrayList<Integer>());
int speed = 25;

void setup() {
  //size(1920, 1080);
  size(1536, 864);
  surface.setLocation(160, 90);
  //map.add(centerRoom);
  centerRoom.obstacles.add(obst1);
  //centerRoom.obstacles.add(obst2);
  //centerRoom.obstacles.add(obst3);
}

void draw() {
  background(125);
  centerRoom.placeObstacles();
  fill(255);
  rect(hero.pos.x, hero.pos.y, 50, 50);
}

void keyPressed() {
  if (key == 's' && !hero.cannotGo(obst1, 3)) {
    hero.pos.y += speed;
  }
  if (key == 'w' && !hero.cannotGo(obst1, 1)) {
    hero.pos.y -= speed;
  }
  if (key == 'a' && !hero.cannotGo(obst1, 4)) {
    hero.pos.x -= speed;
  }
  if (key == 'd' && !hero.cannotGo(obst1, 2)) {
    hero.pos.x += speed;
  }
}
