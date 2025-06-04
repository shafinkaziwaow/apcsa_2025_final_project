class enemy extends entity {
  
  int range;
  int moveCoolDown;
  
  public enemy(String name, int hp, int maxHP, int atk, PVector pos, int dir, int range, int atkCoolDown) {
    super(name, hp, maxHP, atk, pos, dir);
    this.range = range;
    this.atkCoolDown = atkCoolDown;
    this.moveCoolDown = 10;
  }
  
    public void move(player p, room r) {
      if (!cannotGoes(r, dir)) {
        if (ticks % 5 == 0) {
          newDir(p, r);
        } 
          if (dir == 1) {
            this.pos.y -= spd;
          }
          else if (dir == 2) {
            this.pos.x += spd;
          }
          else if (dir == 3) {
            this.pos.y += spd;
          }
          else if (dir == 4) {
            this.pos.x -= spd;
        }
        ticks++;
      }
  }
  
  //public void newDir() {
  //  dir = (int) (Math.random() * 4) + 1; 
  //  ticks++;
  //}
  
  public void newDir(player p, room r) {
    float closeX = p.pos.x - this.pos.x;
    float closeY = p.pos.y - this.pos.y;
    int horizontalDir; 
    int verticalDir;
    int preferreDir;
    
    if (closeX > 0) { 
        horizontalDir = 2; // right
    } else {
        horizontalDir = 4; // left
    }

    if (closeY > 0) {
        verticalDir = 3; // down
    } else {
        verticalDir = 1; // up
    }


    if (Math.abs(closeX) > Math.abs(closeY)) { // if we're closer horizontally than vertically
        if (cannotGoes(r, horizontalDir)) { // if we cant go horizontally
            preferreDir = verticalDir; // change to closer vertical direction
        } else {
            preferreDir = horizontalDir; // if not, stay with horizontal
        }
    } else { // vice versa
        if (cannotGoes(r, verticalDir)) {
            preferreDir = horizontalDir;
        } else {
            preferreDir = verticalDir;
        }
    }

    float chance = (float) Math.random();
    if (chance < 0.8) { // 80% chance to chase
        dir = preferreDir;
    //} else { // 20% chance for random
    //    //dir = (int)(Math.random() * 4) + 1;
    //}
  }
    ticks++; 
  }

  
}
