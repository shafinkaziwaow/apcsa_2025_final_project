class enemy extends entity {
  
  int range;
  int atkCoolDown;
  int moveCoolDown;
  
  public enemy(String name, int hp, int atk, PVector pos, int range, int atkCoolDown) {
    super(name, hp, atk, pos);
    this.range = range;
    this.atkCoolDown = atkCoolDown;
    this.moveCoolDown = 10;
  }
  
    public void move(int spd, player p) {
    if (ticks % 10 == 0) {
      newDir(p);
    } 
    //else {
      if (dir % 4 == 1) {
        this.pos.y -= spd;
      }
      else if (dir % 4 == 2) {
        this.pos.x += spd;
      }
      else if (dir % 4 == 3) {
        this.pos.y += spd;
      }
      else if (dir % 4 == 0) {
        this.pos.x -= spd;
      //}
    }
    ticks++;
  }
  
  //public void newDir() {
  //  dir = (int) (Math.random() * 4) + 1; 
  //  ticks++;
  //}
  
  public void newDir(player p) {
    float closeX = p.pos.x - this.pos.x;
    float closeY = p.pos.y - this.pos.y;
    
    int preferredDir;
    
    if (Math.abs(closeX) > Math.abs(closeY)) {
      if (closeX > 0) {
        preferredDir = 2; // right
      } else {
        preferredDir = 4; // left
      }
    } else {
      if (closeY > 0) {
        preferredDir = 3; // down
      } else {
        preferredDir = 1; // up
      }
    }
  
  float chance = (float) Math.random();
  
  if (chance < 0.7) {
    dir = preferredDir;
  } else {
    dir = (int)(Math.random() * 4) + 1;
  }
  
  ticks++;
}

  
  //public boolean playerInRange(player p) {
  //  float closeX = (p.pos.x + this.pos.x + 50;
  //  float closeY = p.pos.y - this.pos.y + 50;
  
  //  if (dir == 1) { // up
  //    return closeY < 0 && Math.abs(closeX) < range && Math.abs(closeY) < range;
  //  }
  //  if (dir == 2) { // right
  //    return closeX > 0 && Math.abs(closeY) < range && Math.abs(closeX) < range;
  //  }
  //  if (dir == 3) { // down
  //    return closeY > 0 && Math.abs(closeX) < range && Math.abs(closeY) < range;
  //  }
  //  if (dir == 4) { // left
  //    return closeX < 0 && Math.abs(closeY) < range && Math.abs(closeX) < range;
  //  }
  
  //  return false;
  //}
  
  public boolean playerInRange(player p) {
    float closeX = (p.pos.x + 25) - (this.pos.x + 25);
    float closeY = (p.pos.y + 25) - (this.pos.y + 25);
    return closeX * closeX + closeY * closeY <= range * range;
  }
  
}
