ArrayList<room> map = new ArrayList<room>();
ArrayList<room> map2 = new ArrayList<room>();
ArrayList<room> map3 = new ArrayList<room>();
ArrayList<ArrayList<room>> fullMap = new ArrayList<ArrayList<room>>();
int generalMessageDuration;
String generalMessage;
room currentRoom;
String pauseMessage = "";
float atkAng = 0;
int hindex = 1; // horizontal index
int vindex = 0; // vertical index
room levelOneL = new room();
room levelOneC = new room();
room levelOneR = new room();
room levelTwoL = new room();
room levelTwoC = new room();
room levelTwoR = new room();
room levelThreeL = new room();
room levelThreeC = new room();
room levelThreeR = new room();
player hero = new player("hero", 100, 100, 50, new PVector(425, 325), new ArrayList<String>(), new ArrayList<Integer>(), 0, 100, 0);
entity sword = new entity("sword", 0, 0, 0, new PVector(hero.pos.x, hero.pos.y), 1);
entity projectile = new entity("projectile", 0, 0, hero.atk / 2, new PVector(hero.pos.x, hero.pos.y), 1);
entity bomb = new entity("bomb", 0, 0, hero.atk * 2, new PVector(hero.pos.x, hero.pos.y), 1);
//int speed = 25;

void setup() {
  size(900, 700);
  surface.setLocation(160, 90);
  
  hero.inventoryNames.add("Ammo");
  hero.inventoryNames.add("Bombs");
  hero.inventoryNames.add("Health Potions");
  hero.inventoryQuantities.add(0);
  hero.inventoryQuantities.add(0);
  hero.inventoryQuantities.add(0);

  //hero.spd = 50;

  
  map.add(levelOneL);
  map.add(levelOneC);
  map.add(levelOneR);
  fullMap.add(map);
  levelOneL.addObstacle(100, 100, 500, 200, 0);
  levelOneL.addObstacle(200, 200, 225, 500, 0);
  levelOneL.addObstacle(25, 100, 0, height / 2 - 50, 0);
  levelOneL.addEnemy(50, 100);
  levelOneL.addEnemy(800, 600);
  levelOneR.addObstacle(200, 300, 325, 200, 0);
  levelOneR.addObstacle(25, 100, width - 25, height / 2 - 50, 0);
  levelOneR.addEnemy(650, 100);
  
  map2.add(levelTwoL);
  map2.add(levelTwoC);
  map2.add(levelTwoR);
  fullMap.add(map2);
  levelTwoL.addObstacle(600, 400, 600, 400, 0);
  levelTwoL.addObstacle(25, 100, 0, height / 2 - 50, 0);
  levelTwoL.addEnemy(700, 75);
  levelTwoC.addObstacle(350, 200, 150, 300, 0);
  levelTwoC.addEnemy(50, 50, "enemy", 250, 50, 2);
  levelTwoC.addEnemy(600, 75, "enemy", 250, 50, 3);
  levelTwoC.addEnemy(675, 600, "enemy", 350, 50, 2); 
  levelTwoR.addObstacle(25, 100, width - 25, height / 2 - 50, 0);
  levelTwoR.addObstacle(50, 550, 175, 0, 0);
  levelTwoR.addEnemy(75, 25, "enemy", 150, 35, 3);
  levelTwoR.addEnemy(100, 125, "enemy", 200, 35, 3);
  levelTwoR.addEnemy(75, 225, "enemy", 150, 35, 3);
  levelTwoR.addEnemy(750, 600, "distaction man", 500, 25, 4);
  
  map3.add(levelThreeL);
  map3.add(levelThreeC);
  map3.add(levelThreeR);
  fullMap.add(map3);
  levelThreeL.addObstacle(25, 100, 0, height / 2 - 50, 0);
  levelThreeC.addObstacle(0);
  levelThreeC.addObstacle(0);
  levelThreeR.addObstacle(0);
  levelThreeR.addObstacle(25, 100, width - 25, height / 2 - 50, 0);
  
  currentRoom = levelOneC;


  
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
  //if paused
  if (hero.isPaused) {
    background(0);
    textSize(35);
    fill(255);
    text(pauseMessage, 100, 100);
  } else {
    load();
    
    //hero stuff
    sword.pos = hero.pos;
    textSize(30);
    text("HP: " + hero.hp + " / " + hero.maxHP, 35, 50);
    text("ATK cooldown: " + hero.atkCoolDown, 35, 90);
    text("Level: " + hero.level, 35, 130);
    text("EXP: " + hero.exp + " / " + hero.expToNextLevel,  35, 170);
    
    // handle enemies dying and put their info on the screen
    for (enemy e : currentRoom.enemies) {
      textSize(15);
      text("HP: " + e.hp, e.pos.x, e.pos.y - 10);
      if (e.hp <= 0) {
        String message = "";
        double chanceDropAmmo = Math.random();
        double chanceDropHPot = Math.random();
        double chanceDropBomb = Math.random();
        
        //ammo
        if (chanceDropAmmo < 0.6) {
          int dropAmmount = (int) (Math.random() * 4) + 1;
          message += e.name + " dropped " + dropAmmount + " ammo!" + "\n";
          hero.inventoryQuantities.set(0, hero.inventoryQuantities.get(0) + dropAmmount);
        }
        
        // bomb
        if (chanceDropBomb < 0.25) {
          int dropAmmount = (int) (Math.random() * 3) + 1;
          message += e.name + " dropped " + dropAmmount + " bombs!" + "\n";
          hero.inventoryQuantities.set(1, hero.inventoryQuantities.get(1) + dropAmmount);
        }
        
        // hp potion 
        if (chanceDropHPot < 0.34) { 
          int dropAmmount = (int) (Math.random() * 2) + 1;
          message += e.name + " dropped " + dropAmmount + " Health Potions!" + "\n";
          hero.inventoryQuantities.set(2, hero.inventoryQuantities.get(2) + dropAmmount);
        }
        
        if (message.length() > 0) { // if you actually have something to report, overwrite generalMessage 
          generalMessage = message;
          generalMessageDuration = 100;
        }
        currentRoom.enemies.remove(e);
        hero.addExp(50);
        break;
      }
      
    }
    
    // put a general message on the screen
    if (generalMessageDuration > 0) {
      textSize(30);
      fill(0, 255, 0);
      text(generalMessage, 300, 65);
      generalMessageDuration--;
    }
    
    // melee attack
    if (hero.atkCoolDown > 0) {
      hero.atkCoolDown--;
      atkAng -= 0.25;
      push();
      translate(hero.pos.x + 25, hero.pos.y + 25);
      rotate(atkAng);
      fill(0, 255, 0);
      rect(0, -2.5, 75, 5);
      pop();
      for (enemy e : currentRoom.enemies) {
        if (sword.inRange(e, 75) && !sword.enemiesHit.contains(e)) {
          hero.attack(e);
          sword.enemiesHit.add(e);
        }
      }
    }
    
    // ranged attack
    if (projectile.ticks > 0) {
      projectile.move(currentRoom);
      for (enemy e : currentRoom.enemies) {
        if (projectile.inRange(e, 50) && !projectile.enemiesHit.contains(e)) {
          projectile.attack(e);
          projectile.enemiesHit.add(e);
        }
      }
      projectile.ticks--;
      fill(0, 255, 0);
      rect(projectile.pos.x, projectile.pos.y, 10, 10);
    }
    
    // bomb
    if (bomb.ticks > 0) {
      bomb.move(currentRoom);
      for (enemy e : currentRoom.enemies) {
        if (bomb.inRange(e, 50)) {
          bomb.attack(e);
          bomb.ticks = 0;
        } 
      }
      bomb.ticks--;
      fill(0, 255, 0);
      rect(bomb.pos.x, bomb.pos.y, 25, 25);
      if (bomb.ticks <= 0 && bomb.inRange(hero, 50)) {
          bomb.attack(hero); 
      }
    }
   
    
    // hero dying
    if (hero.hp <= 0) {
      background(0);
      textSize(100);
      fill(255, 0, 0);
      text("You Died!", 250, 370);
    }
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
    hero.dir = 3;
    hero.pos.y += hero.spd;
  }
  if (key == 'w' && !hero.cannotGoes(currentRoom, 1)) {
    hero.dir = 1;
    hero.pos.y -= hero.spd;
  }
  if (key == 'a' && !hero.cannotGoes(currentRoom, 4)) {
    hero.dir = 4;
    hero.pos.x -= hero.spd;
  }
  if (key == 'd' && !hero.cannotGoes(currentRoom, 2)) {
    hero.dir = 2;
    hero.pos.x += hero.spd;
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
    
    else if (hero.pos.x <= 0) { // going left 
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
    sword.enemiesHit = new ArrayList<enemy>();
  }
  
  if (key == 'k' && hero.inventoryQuantities.get(0) > 0) {
    projectile = new entity("projectile", 0, 0, hero.atk / 2, new PVector(hero.pos.x, hero.pos.y), hero.dir);
    projectile.ticks = 50;
    hero.inventoryQuantities.set(0, hero.inventoryQuantities.get(0) - 1);
  }
  
  if (key == 'l' && hero.inventoryQuantities.get(1) > 0) {
    bomb = new entity("bomb", 0, 0, hero.atk * 2, new PVector(hero.pos.x, hero.pos.y), hero.dir);
    bomb.ticks = 30;
    bomb.spd = 10;
    hero.inventoryQuantities.set(1, hero.inventoryQuantities.get(1) - 1);
  }
  
  if (key == 'h' && hero.inventoryQuantities.get(2) > 0) {
    hero.hp = Math.min(hero.hp + 50, hero.maxHP);
    hero.inventoryQuantities.set(2, hero.inventoryQuantities.get(2) - 1);
  }
  
  if (key == 'p') {
    hero.isPaused = !hero.isPaused;
    pauseMessage = "PAUSED" + "\n" + "\n";
    pauseMessage += "Controls: " + "\n";
    pauseMessage += "W - up" + "\n" + "A - left" + "\n" + "S - down" + "\n" + "D - right" + "\n" + "I - interact" + "\n" + "J - melee attack" + "\n" + "K - ranged attack" + "\n" + "L - bomb" + "\n" + "H - health potion" + "\n" + "E - inventory"; 
  }
  
  if (key == 'e') {
    hero.isPaused = !hero.isPaused;
    pauseMessage = "Inventory: "  + "\n";
    for (int i = 0; i < hero.inventoryNames.size(); i++) {
      pauseMessage += hero.inventoryNames.get(i) + " (" + hero.inventoryQuantities.get(i) + ")" + "\n"; 
    }
  }
  

}
