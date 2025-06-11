class room {
  //int width = 1550;
  //int height = 875;
  int width = 900;
  int height = 700;
  public ArrayList<obstacle> obstacles; // coordinates of any obstacles in the room 
  public ArrayList<enemy> enemies; // coordinates of any enemies in the room 
  public ArrayList<boss> bosses;
  PImage wall, enemy1, enemy2, axe, dagger;
  int spriteTicks; 
  int prevSpr;
  player p;
  
  public room () {
    this.obstacles = new ArrayList<obstacle>();
    this.enemies = new  ArrayList<enemy>();
    this.bosses = new ArrayList<boss>();
    this.wall = loadImage("walltest.jpg");
    this.enemy1 = loadImage("2D Pixel Dungeon Asset Pack/Character_animation/monsters_idle/skull/v2/skull_v2_1.png");
    this.enemy2 = loadImage("2D Pixel Dungeon Asset Pack/Character_animation/monsters_idle/skeleton2/v2/skeleton2_v2_1.png");
    this.axe = loadImage("Pack Icons 2/scytheR.png");
    this.dagger = loadImage("Pack Icons 2/knifeR.png");
    this.spriteTicks = 0;
    this.prevSpr = 1;
  }
  
  public room(ArrayList<obstacle> obstacles, ArrayList<enemy> enemies, ArrayList<boss> bosses) {
    this.obstacles = obstacles;
    this.enemies = enemies;
    this.bosses = bosses;
  }
  
  public void placeObstacles() {
    for (obstacle ob : obstacles) {
      stroke(0);
      fill(0); 
      for (int i = 0; i < ob.w / 25; i++) {
        for (int j = 0; j < ob.h / 25; j++) {
          copy(wall, 0, 0, 15, 15, (int) ob.pos.x + i * 25, (int) ob.pos.y + j * 25, 25, 25);
        }
      }
      //rect(ob.pos.x, ob.pos.y, ob.w, ob.h);
    }
  }
  
  public void addObstacle(int w, int h, int x, int y, color c) {
    obstacle newObst = new obstacle(w, h, new PVector(x, y), c);
    obstacles.add(newObst);
  }
  
  public void addObstacle(color c) {
    obstacle newObst = new obstacle(c);
    obstacles.add(newObst);
  }
  
  public void placeEnemies() {
    for (enemy e : enemies) {
      //stroke(0);
      //fill(255, 0, 0);
      //rect(e.pos.x, e.pos.y, 50, 50);
      if (this.spriteTicks % 50 == 0) {
        prevSpr = (prevSpr + 1) % 4 + 1;
        enemy1 = loadImage("2D Pixel Dungeon Asset Pack/Character_animation/monsters_idle/skull/v2/skull_v2_" + prevSpr + ".png");
      }
      copy(enemy1, 0, 0, 16, 16, (int) e.pos.x, (int) e.pos.y, 60, 60);
      behavior(e);
    }
  }
  
  public void behavior(enemy e) {
      if (e.cannotGoes(this, e.dir)) {
        e.newDir(p, this);
      } else { 
        if (e.inRange(p, e.range)) {
          if (e.atkCoolDown > 0) {
            e.atkCoolDown--;
          } else {
            e.attack(p);
            e.atkCoolDown = 100;
          }
        } else {
          if (e.moveCoolDown == 0) {
            if (!e.cannotGoes(this, e.dir)) {
              e.move(p, this);
            } else {
              e.newDir(p, this);
            }
            e.moveCoolDown = 10;
          }
            else {
            e.moveCoolDown--;
          }
        }
      }
  }
  
  public void addEnemy(int x, int y, String name, int hp, int atk, int dir) {
    enemy newEnemy = new enemy(name, hp, hp, atk, new PVector(x, y), dir, 50, 30);
    enemies.add(newEnemy);
  }
  
  public void addEnemy(int x, int y) {
    enemy newEnemy = new enemy("skull", 100, 100, 25, new PVector(x, y), 3, 50, 30);
    enemies.add(newEnemy);
  }
  
  public void addBoss(int x, int y, String name, int hp, int maxHP, int atk, int dir) {
    boss newBoss = new boss(name, hp, maxHP, atk, new PVector(x, y), dir, 50, 30);
    bosses.add(newBoss);
  }
  
  public void placeBosses() {
    for (boss b : bosses) {
      //stroke(0);
      //fill(255, 0, 0); 
      //rect(b.pos.x, b.pos.y, 50, 50);
      if (this.spriteTicks % 50 == 0) {
        prevSpr = (prevSpr + 1) % 4 + 1;
        enemy2 = loadImage("2D Pixel Dungeon Asset Pack/Character_animation/monsters_idle/skeleton2/v2/skeleton2_v2_" + prevSpr + ".png");
      }
      push();
      translate(b.pos.x + 40, b.pos.y + 40);
      if (b.dir == 4) {
        scale(-1, 1);
      }
      copy(enemy2, 0, 0, 16, 16, -40, -40, 60, 60);
      pop();
      if (b.cannotGoes(this, b.dir)) {
        b.newDir(p, this);
        b.bossProjectile.dir = b.dir;
      } else {
        if (b.atkCoolDown > 0) {
          b.atkCoolDown--;
        } else {
          b.atkCoolDown = 70;
          if (b.inRange(p, 75)) {
            b.attack(p);
          } else {
            b.bossProjectile = new entity("projectile", 0, 0, b.atk / 4, new PVector(b.pos.x, b.pos.y), b.dir);
            b.bossProjectile.ticks = 50;
          }
        }
        atkAng -= 0.2;
        push();
        translate(b.pos.x + 25, b.pos.y + 25);
        rotate(atkAng);
        //fill(0);
        //rect(0, -2.5, 66, 5);
        copy(axe, 0, 0, 32, 32, 20, 0, 50, 50);
        pop();
       if (b.moveCoolDown == 0) {
         if (!b.cannotGoes(this, b.dir)) {
           b.move(p, this);
         } else {
           b.newDir(p, this);
           b.bossProjectile.dir = b.dir;
         }
         b.moveCoolDown = 10;
       } else {
         b.moveCoolDown--;
       } 
      }
    } 
  }
  
}
