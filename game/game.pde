ArrayList<room> map = new ArrayList<room>();
ArrayList<room> map2 = new ArrayList<room>();
ArrayList<ArrayList<room>> fullMap = new ArrayList<ArrayList<room>>();
room currentRoom;
float atkAng = 0;
int hindex = 1; // horizontal index
int vindex = 0; // vertical index
room levelOneL = new room();
room levelOneC = new room();
room levelOneR = new room();
room levelTwoL = new room();
room levelTwoC = new room();
room levelTwoR = new room();
player hero = new player("hero", 100, 50, new PVector(width / 2, height / 2), new ArrayList<String>(), new ArrayList<Integer>());
entity sword = new entity("playerSword", 0, 0, new PVector(hero.pos.x, hero.pos.y));
int speed = 25;

void setup() {
  size(900, 700);
  surface.setLocation(160, 90);
  
  map.add(levelOneL);
  map.add(levelOneC);
  map.add(levelOneR);
  fullMap.add(map);
  levelOneL.addObstacle(100, 100, 500, 200, 0);
  levelOneL.addObstacle(200, 200, 250, 500, 0);
  levelOneL.addEnemy(50, 100);
  levelOneL.addEnemy(800, 600);
  levelOneR.addObstacle(200, 300, 300, 300, 0);
  levelOneR.addEnemy(650, 100);
  currentRoom = levelOneC;
  
  map2.add(levelTwoL);
  map2.add(levelTwoC);
  map2.add(levelTwoR);
  fullMap.add(map2);
  levelTwoL.addObstacle(600, 400, 600, 400, 0);
  levelTwoC.addObstacle(350, 200, 900, 800, 0);
  
  for (ArrayList<room> rL : fullMap) {
    for (room r : rL) {
      r.p = hero;
      r.addObstacle(width, 25, 0, 0, 0);
      r.addObstacle(25, height / 2 - 50, width - 25, 0, 0);
      r.addObstacle(25, height / 2 - 50, width - 25, height / 2 + 50, 0);
      r.addObstacle(25, height / 2 - 50, 0, 0, 0);
      r.addObstacle(25, height / 2, 0, height / 2 + 50, 0);
      r.addObstacle(width / 2 - 50, 25, 0, height - 25, 0);
      r.addObstacle(width / 2 - 50, 25, width / 2 + 50, height - 25, 0);
    }
  }
}

void draw() {
  load();
  sword.pos = hero.pos;
  textSize(30);
  text("HP: " + hero.hp, 35, 50);
  text("ATK cooldown: " + hero.atkCoolDown, 35, 90);
  
  for (enemy e : currentRoom.enemies) {
    textSize(15);
    text("HP: " + e.hp, e.pos.x, e.pos.y - 10);
    if (e.hp <= 0) {
      currentRoom.enemies.remove(e);
      break;
    }
  }
  
  if (hero.atkCoolDown > 0) {
    hero.atkCoolDown--;
    atkAng -= 0.25;
    push();
    translate(hero.pos.x + 25, hero.pos.y + 25);
    rotate(atkAng);
    fill(0, 0, 255);
    rect(0, -2.5, 75, 5);
    pop();
  }
  
  if (hero.hp <= 0) {
    background(0);
    textSize(100);
    fill(255, 0, 0);
    text("You Died!", 250, 370);
  }
  
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
      if (hindex != fullMap.get(vindex).size() -1 && fullMap.get(vindex).get(hindex + 1) != null) {
        hindex++;
        hero.pos.x = 25;
        fullMap.get(vindex).get(hindex).addObstacle(25, 100, 0, height / 2 - 50, 0);
        fullMap.get(vindex).get(hindex).addObstacle(25, 100, width - 25, height / 2 - 50, 0);
      }
      currentRoom = fullMap.get(vindex).get(hindex);
    }
    
    else if (hero.pos.x <= 0 + 50) { // going left 
      if (hindex != 0 && fullMap.get(vindex).get(hindex - 1) != null) {
        hindex--;
        hero.pos.x = width - 75;
        fullMap.get(vindex).get(hindex).addObstacle(25, 100, 0, height / 2 - 50, 0);
        fullMap.get(vindex).get(hindex).addObstacle(25, 100, width - 25, height / 2 - 50, 0);
      }
      currentRoom = fullMap.get(vindex).get(hindex);
    }
    
    //else if (hero.pos.y <= 0 + 50) { // going up
    //  if (vindex != 0 && fullMap.get(vindex - 1).get(hindex) != null) {
    //    vindex--;
    //    hero.pos.y = height - 50;
    //  }
    //  currentRoom = fullMap.get(vindex).get(hindex);
    //} 
    
    else if (hero.pos.y >= height - 50) { // going down
      if (vindex != fullMap.size() - 1 && fullMap.get(vindex + 1).get(hindex) != null) {
      //if (vindex != fullMap.size() - 1 && fullMap.get(vindex + 1).get(hindex) != null) {
        vindex++;
        hero.pos.y = 25;
      }
      currentRoom = fullMap.get(vindex).get(hindex);
    }
    load();
  }
  
  if (key == 'j' && hero.atkCoolDown == 0) {
    hero.atkCoolDown = 30;
    for (enemy e : currentRoom.enemies) {
      if (sword.inRange(e, 75)) {
        hero.attack(e);
        //hero.atkCoolDown = 30;
        break;
      }
    }
  }

}
