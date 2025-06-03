class enemy extends entity {
  
  int range;
  int moveCoolDown;
  
  public enemy(String name, int hp, int atk, PVector pos, int range, int atkCoolDown) {
    super(name, hp, atk, pos, 1);
    this.range = range;
    this.atkCoolDown = atkCoolDown;
    this.moveCoolDown = 10;
  }
  
    public void move(int spd, player p, room r) {
    if (ticks % 5 == 0) {
      newDir(p, r);
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
  
  public void newDir(player p, room r) {
    float closeX = p.pos.x - this.pos.x;
    float closeY = p.pos.y - this.pos.y;
    
    int preferreDir;
    
    if (Math.abs(closeX) > Math.abs(closeY) || (cannotGoes(r, 1) && cannotGoes(r, 3))) { // if closer horizontally 
      if (closeX > 0) {
        preferreDir = 2; // right
      } else {
        preferreDir = 4; // left
      }
    } else {
      if (closeY > 0 || (cannotGoes(r, 2) && cannotGoes(r, 4))) {
        preferreDir = 3; // down
      } else {
        preferreDir = 1; // up
      }
    }
  
    float chance = (float) Math.random();
    
    if (chance < 0.8) {
      dir = preferreDir;
    } else {
      dir = (int)(Math.random() * 4) + 1;
    }
    
    ticks++;
  }
  
}
