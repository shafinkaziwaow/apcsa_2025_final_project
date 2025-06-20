int gameState; // 0 = start screen, 1 = playing 
ArrayList<room> map;
ArrayList<room> map2;
ArrayList<room> map3;
ArrayList<ArrayList<room>> fullMap;
int generalMessageDuration;
String generalMessage;
room currentRoom;
String pauseMessage;
float atkAng;
int hindex; // horizontal index
int vindex; // vertical index
room levelOneL;
room levelOneC;
room levelOneR;
room levelTwoL;
room levelTwoC;
room levelTwoR;
room levelThreeL;
room levelThreeC;
room levelThreeR;
room finalRoom;
player hero;
entity sword;
entity projectile;
entity bomb;
entity chest;
PImage gurt, bro, swordSpr, arrow, farrow, chestSpr;
int sprX, sprY;

//int speed = 25;

void setup() {
  gurt = loadImage("mainlevbuildtest3.jpg");
  bro = loadImage("Human-Soldier-Red.png");
  swordSpr = loadImage("Pack Icons 2/SwordRotate90.png");
  arrow = loadImage("Pack Icons 2/arRotated.png");
  farrow = loadImage("Pack Icons 2/flArRotated.png");
  chestSpr = loadImage("Dungeon_Tileset.png");
  sprX = 37;
  sprY = 2;
  
  gameState = 0;
  map = new ArrayList<room>();
  map2 = new ArrayList<room>();
  map3 = new ArrayList<room>();
  fullMap = new ArrayList<ArrayList<room>>();
  pauseMessage = "";
  atkAng = 0;
  levelOneL = new room();
  levelOneC = new room();
  levelOneR = new room();
  levelTwoL = new room();
  levelTwoC = new room();
  levelTwoR = new room();
  levelThreeL = new room();
  levelThreeC = new room();
  levelThreeR = new room();
  finalRoom = new room();
  hero = new player("hero", 100, 100, 34, new PVector(425, 325), new ArrayList<String>(), new ArrayList<Integer>(), 0, 100, 0);
  sword = new entity("sword", 0, 0, 0, new PVector(hero.pos.x, hero.pos.y), 1);
  projectile = new entity("projectile", 0, 0, hero.atk / 2, new PVector(hero.pos.x, hero.pos.y), 1);
  bomb = new entity("bomb", 0, 0, hero.atk * 2, new PVector(hero.pos.x, hero.pos.y), 1);
  chest = new entity("chest", 0, 0, 0, new PVector(800, 325), 0);
  
  size(900, 700);
  surface.setLocation(160, 90);
  
  hero.inventoryNames.add("Arrows");
  hero.inventoryNames.add("Fire Arrows");
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
  //levelOneC.addBoss(100, 100, "test", 100, 100, 25, 1);
  levelOneR.addObstacle(200, 300, 325, 200, 0);
  levelOneR.addObstacle(25, 100, width - 25, height / 2 - 50, 0);
  levelOneR.addEnemy(650, 100);
  
  map2.add(levelTwoL);
  map2.add(levelTwoC);
  map2.add(levelTwoR);
  fullMap.add(map2);
  levelTwoL.addObstacle(600, 400, 600, 400, 0);
  levelTwoL.addObstacle(100, 300, 300, 225, 0);
  levelTwoL.addObstacle(500, 75, 400, 225, 0);
  levelTwoL.addObstacle(25, 100, 0, height / 2 - 50, 0);
  levelTwoL.addEnemy(700, 75, "skull", 150, 35, 4);
  levelTwoL.addEnemy(100, 500, "skull", 200, 50, 1);
  levelTwoL.addEnemy(800, 325, "guard", 350, 75, 1);
  levelTwoC.addObstacle(350, 200, 150, 300, 0);
  levelTwoC.addObstacle(300, 200, 600, 0, 0);
  levelTwoC.addObstacle(100, 125, 25, 550, 0);
  levelTwoC.addEnemy(50, 50, "skull", 250, 50, 2);
  levelTwoC.addEnemy(600, 225, "skull", 250, 50, 3);
  levelTwoC.addEnemy(675, 600, "skull", 350, 50, 2); 
  levelTwoR.addObstacle(25, 100, width - 25, height / 2 - 50, 0);
  levelTwoR.addObstacle(50, 550, 175, 0, 0);
  levelTwoR.addEnemy(75, 25, "skull", 150, 35, 3);
  levelTwoR.addEnemy(100, 125, "skull", 200, 35, 3);
  levelTwoR.addEnemy(75, 225, "skull", 150, 35, 3);
  levelTwoR.addEnemy(750, 600, "distaction man", 500, 25, 4);
  
  map3.add(levelThreeL);
  map3.add(levelThreeC);
  map3.add(levelThreeR);
  map3.add(finalRoom);
  fullMap.add(map3);
  levelThreeL.addObstacle(25, 100, 0, height / 2 - 50, 0);
  levelThreeL.addEnemy(100, 100, "skull", 150, 50, 1);
  levelThreeL.addEnemy(200, 200, "skull", 150, 50, 1);
  levelThreeL.addEnemy(300, 300, "skull", 150, 50, 1);
  levelThreeL.addEnemy(400, 400, "skull", 150, 50, 1);
  levelThreeL.addEnemy(500, 500, "skull", 150, 50, 1);
  levelThreeL.addEnemy(600, 600, "skull", 150, 50, 1);
  levelThreeL.addEnemy(600, 100, "skull", 150, 50, 1);
  levelThreeL.addEnemy(500, 200, "skull", 150, 50, 1);
  levelThreeL.addEnemy(400, 300, "skull", 150, 50, 1);
  levelThreeL.addEnemy(300, 400, "skull", 150, 50, 1);
  levelThreeL.addEnemy(200, 500, "skull", 150, 50, 1);
  levelThreeL.addEnemy(100, 600, "skull", 150, 50, 1);
  levelThreeC.addObstacle(100, 100, width / 2 - 150, height / 2 - 150, 0);
  levelThreeC.addObstacle(100, 100, width / 2 + 50, height / 2 - 150, 0);
  levelThreeC.addObstacle(100, 100, width / 2 - 150, height / 2 + 50, 0);
  levelThreeC.addObstacle(100, 100, width / 2 + 50, height / 2 + 50, 0);
  levelThreeC.addObstacle(150, 150, 25, 25, 0);
  levelThreeC.addObstacle(150, 150, 25, height - 175, 0);
  levelThreeC.addObstacle(150, 150, width - 175, 25, 0);
  levelThreeC.addObstacle(150, 150, width - 175, height - 175, 0);
  levelThreeC.addEnemy(200, 50, "skull", 200, 33, 2); 
  levelThreeC.addEnemy(width - 250, 50, "skull", 150, 33, 4); 
  levelThreeC.addEnemy(75, height - 250, "skull", 200, 33, 1); 
  levelThreeC.addEnemy(75, height - 500, "skull", 150, 33, 3); 
  levelThreeC.addEnemy(width - 150, height - 250, "skull", 200, 33, 1); 
  levelThreeC.addEnemy(width - 150, height - 500, "skull", 150, 33, 3); 
  levelThreeC.addEnemy(width / 2 - 25, height - 75, "skull", 400, 50, 1);
  levelThreeR.addObstacle(75, 10000, 550, 0, 0);
  levelThreeR.addObstacle(50, 50, (int) chest.pos.x, (int) chest.pos.y, 0);
  levelThreeR.addObstacle(25, 100, width - 25, height / 2 - 50, 0);
  levelThreeR.addBoss(400, 500, "chest guardian", 250, 250, 25, 1);
  
  finalRoom.addObstacle(100, 25, width / 2 - 50, height - 25, 0);
  finalRoom.addObstacle(25, 100, 0, height / 2 - 50, 0);
  finalRoom.addObstacle(25, 100, width - 25, height / 2 - 50, 0);
  finalRoom.addObstacle(150, 150, 150, 150, 0);
  finalRoom.addObstacle(200, 200, 550, 400, 0);
  finalRoom.addEnemy(width / 2 - 25, height / 2 - 25, "skull", 900, 45, 1);
  finalRoom.addBoss(75, 175, "boss 1", 450, 250, 50, 1);
  finalRoom.addBoss(800, 475, "boss 2", 450, 250, 50, 1);
  
  currentRoom = levelOneC;
  hindex = 1;
  vindex = 0;


  
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
  if (hero.isPaused) {
    background(90);
    textSize(35);
    fill(255);
    text(pauseMessage, 100, 100);
    if (vindex == 4 && keyCode == ENTER) {
      setup();
    }
  } else {
  if (gameState == 0) {
    background(90);
    fill(255);
    textSize(40);
    text("The Binding of Processing", 230, 300);
    textSize(20);
    text("Press ENTER to start", 350, 370);
    text("Press P for controls", 350, 400);
    text("Press O for objective", 350, 430);
  } else {
    
    load();
    
    currentRoom.spriteTicks++;
    
    //hero stuff
    sword.pos = hero.pos;
    textSize(30);
    text("HP: " + hero.hp + " / " + hero.maxHP, 35, 50);
    text("ATK cooldown: " + hero.atkCoolDown, 35, 90);
    text("Level: " + hero.level, 35, 130);
    text("EXP: " + hero.exp + " / " + hero.expToNextLevel,  35, 170);
    
    //chest 
    if (hindex == 2 && vindex == 2) {
      //fill(0, 255, 0);
      //rect(chest.pos.x, chest.pos.y, 50, 50);
      copy(chestSpr, 34, 130, 12, 12, (int) chest.pos.x, (int) chest.pos.y, 50, 50);
      if (currentRoom.bosses.isEmpty()) {
        currentRoom.obstacles.get(0).pos = new PVector(100000, 1000000);
      }
      if (hero.inRange(chest, 75) && key == 'i') {
        chest.pos = new PVector(100000, 10000);
        currentRoom.obstacles.get(1).pos = new PVector(10000, 1000000);
        generalMessage = "You found a chest full of supplies!" + "\n" + 
        "You picked up 5 health potions!" + "\n" + 
        "You picked up 10 arrows!" + "\n" + 
        "You picked up 5 fire arrows!";
        generalMessageDuration = 100;
        hero.inventoryQuantities.set(0, hero.inventoryQuantities.get(0) + 10);
        hero.inventoryQuantities.set(1, hero.inventoryQuantities.get(1) + 5);
        hero.inventoryQuantities.set(2, hero.inventoryQuantities.get(2) + 5);
      }
    }
    
    if (finalRoom.enemies.isEmpty() && finalRoom.bosses.isEmpty()) {
      finalRoom.obstacles.get(0).pos = new PVector(100000, 1000000);
    }
    
    
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
          message += e.name + " dropped " + dropAmmount + " arrows!" + "\n";
          hero.inventoryQuantities.set(0, hero.inventoryQuantities.get(0) + dropAmmount);
        }
        
        // bomb
        if (chanceDropBomb < 0.25) {
          int dropAmmount = (int) (Math.random() * 3) + 1;
          message += e.name + " dropped " + dropAmmount + " fire arrows!" + "\n";
          hero.inventoryQuantities.set(1, hero.inventoryQuantities.get(1) + dropAmmount);
        }
        
        // hp potion 
        if (chanceDropHPot < 0.34) { 
          int dropAmmount = (int) (Math.random() * 2) + 1;
          message += e.name + " dropped " + dropAmmount + " health potions!" + "\n";
          hero.inventoryQuantities.set(2, hero.inventoryQuantities.get(2) + dropAmmount);
        }
        
        if (message.length() > 0) { // if you actually have something to report, overwrite generalMessage 
          generalMessage = message;
          generalMessageDuration = 100;
        }
        currentRoom.enemies.remove(e);
        int expToAdd = (int) (Math.random() * 26) + 50;
        hero.addExp(expToAdd);
        break;
      }
      
    }
    
    // handle bosses 
    for (boss b : currentRoom.bosses) {
      if (b.hp <= 0) {
        hero.addExp(100);
        currentRoom.bosses.remove(b);
        break;
      }
      textSize(20);
      fill(255);
      text("HP: " + b.hp, b.pos.x, b.pos.y - 10);
      if (b.bossProjectile.ticks > 0) {
        b.bossProjectile.move(currentRoom);
        if (b.bossProjectile.inRange(hero, 50) && !b.bossProjectile.enemiesHit.contains(hero)) {
          b.bossProjectile.attack(hero);
          b.bossProjectile.enemiesHit.add(hero);
        }
        push();
        translate(b.bossProjectile.pos.x + 25, b.bossProjectile.pos.y + 25);
        if (b.bossProjectile.dir == 1) {
          rotate(-HALF_PI);
        }
        if (b.bossProjectile.dir == 3) {
          rotate(HALF_PI);
        }
        if (b.bossProjectile.dir == 4) {
          rotate(PI);
        }
        copy(currentRoom.dagger, 0, 0, 48, 48, 0, 0, 50, 50);
        pop();
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
      copy(swordSpr, 0, 0, 32, 32, 20, 0, 50, 50);
      pop();
      for (enemy e : currentRoom.enemies) {
        if (sword.inRange(e, 75) && !sword.enemiesHit.contains(e)) {
          hero.attack(e);
          sword.enemiesHit.add(e);
        }
      }
      for (boss b : currentRoom.bosses) {
        if (sword.inRange(b, 75) && !sword.enemiesHit.contains(b)) {
          hero.attack(b);
          sword.enemiesHit.add(b);
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
      for (boss b : currentRoom.bosses) {
        if (projectile.inRange(b, 50) && !projectile.enemiesHit.contains(b)) {
          projectile.attack(b);
          projectile.enemiesHit.add(b);
        }
      }
      projectile.ticks--;
      //fill(0, 255, 0);
      //rect(projectile.pos.x, projectile.pos.y, 10, 10);
      push();
      translate(projectile.pos.x + 25, projectile.pos.y + 25);
      if (projectile.dir == 1) {
        rotate(-HALF_PI);
      }
      if (projectile.dir == 3) {
        rotate(HALF_PI);
      }
      if (projectile.dir == 4) {
        rotate(PI);
      }
      copy(arrow, 0, 0, 48, 48, 0, 0, 50, 50);
      pop();
    }
    
    
    // bomb
    if (bomb.ticks > 0) {
      bomb.move(currentRoom);
      for (enemy e : currentRoom.enemies) {
        if (bomb.inRange(e, 100)) {
          bomb.attack(e);
          bomb.ticks = 0;
        } 
      }
      for (boss b : currentRoom.bosses) {
        if (bomb.inRange(b, 100)) {
          bomb.attack(b);
          bomb.ticks = 0;
        } 
      }
      bomb.ticks--;
      //fill(0, 255, 0);
      //rect(bomb.pos.x, bomb.pos.y, 25, 25);
      push();
      translate(bomb.pos.x + 25, bomb.pos.y + 25);
      if (bomb.dir == 1) {
        rotate(-HALF_PI);
      }
      if (bomb.dir == 3) {
        rotate(HALF_PI);
      }
      if (bomb.dir == 4) {
        rotate(PI);
      }
      copy(farrow, 0, 0, 48, 48, 0, 0, 50, 50);
      pop();
      if (bomb.ticks <= 0 && bomb.inRange(hero, 25)) {
          bomb.attack(hero); 
      }
    }
   
    
    // hero dying
    if (hero.hp <= 0) {
      background(0);
      textSize(100);
      fill(255, 0, 0);
      text("You Died!", 250, 340);
      textSize(40);
      fill(255);
      text("Try Again?", 350, 450);
      text("[ENTER]", 367, 500);
      if (keyCode == ENTER) {
        setup();
      }
    }
  }
  }
}

void load() {
  //background(74, 61, 67);
  background(74, 67, 70);
  
  for (int i = 0; i <= 900 / 31; i++) {
    for (int j = 0; j <= 700 / 31; j++) {
      image(gurt, i * 31, j * 31);
    }
  }
  

  currentRoom.placeObstacles();
  currentRoom.placeEnemies();
  currentRoom.placeBosses();
  fill(255);
  //rect(hero.pos.x, hero.pos.y, 50, 50);
  copy(bro, sprX, sprY, 21, 21, (int) hero.pos.x, (int) hero.pos.y, 50, 50);
}

void keyPressed() {
  if (gameState == 0) {
    if (keyCode == ENTER) {
      gameState = 1;
    }
    if (key == 'p') {
      hero.isPaused = !hero.isPaused;
      pauseMessage = "Controls: " + "\n";
      pauseMessage += "W - up" + "\n" + "A - left" + "\n" + "S - down" + "\n" + "D - right" + "\n" + "I - interact" + "\n" + "J - sword attack" + 
      "\n" + "K - shoot arrow" + "\n" + "L - shoot fire arrow" + "\n" + "H - health potion" + "\n" + "E - inventory" + "\n" + "P - pause";
    } 
    if (key == 'o') {
      hero.isPaused = !hero.isPaused;
      pauseMessage = "You are a hero trapped in a mysterious" + "\n" +
      "dungeon. Every time you enter a room to the" + "\n" + 
      "side, the walls close in on you. The only way" + "\n" + 
      "forward from there is downwards. Descend" + "\n" + 
      "the labyrinth, fighting your way to the end" + "\n" + 
      "for your freedom." + "\n" + "\n" +  
      "You start with just your sword, but you can" + "\n" + 
      "find arrows and fire arrows along the way." + "\n" + 
      "Be careful, fire arrows can damage you if you" + "\n" + 
      "stand too close to them!";
    }
  } else {
  // movement 
  if (key == 's' && !hero.cannotGoes(currentRoom, 3)) {
    sprX = 37;
    sprY = 2;
    hero.dir = 3;
    hero.pos.y += hero.spd;
  }
  if (key == 'w' && !hero.cannotGoes(currentRoom, 1)) {
    sprY = 130;
    hero.dir = 1;
    hero.pos.y -= hero.spd;
  }
  if (key == 'a' && !hero.cannotGoes(currentRoom, 4)) {
    sprY = 194;
    hero.dir = 4;
    hero.pos.x -= hero.spd;
  }
  if (key == 'd' && !hero.cannotGoes(currentRoom, 2)) {
    sprY = 66;
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
      boolean finaling = false;
      if (vindex >= 2) {
        vindex++;
        hero.pos.y = 25;
        finaling = true;
      } else if (vindex != fullMap.size() - 1 && fullMap.get(vindex + 1).get(hindex) != null) {
      //if (vindex != fullMap.size() - 1 && fullMap.get(vindex + 1).get(hindex) != null) {
        vindex++;
        hero.pos.y = 25;
      }
      if (vindex == 4) {
        hero.isPaused = true;
        pauseMessage = "You did it!" + "\n" + 
        "You fought all the way through the" + "\n" + 
        "dungeon and freed yourself." + "\n" + "Congratulations!" + "\n" + "\n" + "\n" + 
        "Play Again?" + "\n" + "[ENTER]";
      } else if (finaling) {
        currentRoom = finalRoom;
      } else {
        currentRoom = fullMap.get(vindex).get(hindex);
      }
    }
    load();
  }
  
  if (key == 'j' && hero.atkCoolDown == 0) {
    hero.atkCoolDown = 30;
    sword.enemiesHit = new ArrayList<entity>();
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
    pauseMessage += "W - up" + "\n" + "A - left" + "\n" + "S - down" + "\n" + "D - right" + "\n" + "I - interact" + "\n" + "J - sword attack" + 
    "\n" + "K - shoot arrow" + "\n" + "L - shoot fire arrow" + "\n" + "H - health potion" + "\n" + "E - inventory" + "\n" + "P - pause";
  }
  
  if (key == 'e') {
    hero.isPaused = !hero.isPaused;
    pauseMessage = "Inventory: "  + "\n";
    for (int i = 0; i < hero.inventoryNames.size(); i++) {
      pauseMessage += hero.inventoryNames.get(i) + " (" + hero.inventoryQuantities.get(i) + ")" + "\n"; 
    }
  }
  }
  
}
