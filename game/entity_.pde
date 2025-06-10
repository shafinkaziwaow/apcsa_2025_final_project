class entity {

  String name;
  int hp;
  int maxHP;
  PVector pos;
  int atk;
  int ticks;
  int dir;
  int atkCoolDown;
  ArrayList<entity> enemiesHit = new ArrayList<entity>();
  int spd;
  
  public entity(String name, int hp, int maxHP, int atk, PVector pos, int dir) {
    this.name = name;
    this.hp = hp;
    this.maxHP = maxHP;
    this.atk = atk;
    this.pos = pos;
    this.ticks = 0;
    this.dir = dir;
    this.atkCoolDown = 60;
    this.spd = 25;
  }
  
  public void attack(entity other) {
    other.hp -= this.atk;  
  }
  
  // i leave this here to remember and reflect on my past mistakes. it was good for a first attempt. all that matters is that i tried. 
  //  public boolean cannotGoObsts(obstacle o, int dir) { // 1 == N, 2 == E, 3 == S, 4 == W
  //  float pLeft = pos.x;
  //  float pRight = pos.x + 50;
  //  float pTop = pos.y;
  //  float pBottom = pos.y + 50;
  //  float oLeft = o.pos.x;
  //  float oRight = o.pos.x + o.w;
  //  float oTop = o.pos.y;
  //  float oBottom = o.pos.y + o.h;
    
  //  if (dir % 4 == 1) {
  //    return (pTop <= 0 || pTop - spd < oBottom && pBottom > oBottom && pRight > oLeft && pLeft < oRight);
  //  } else if (dir % 4 == 2) {
  //    return (pRight >= width || pRight + spd > oLeft && pLeft < oLeft && pBottom > oTop && pTop < oBottom);
  //  } else if (dir % 4 == 3) {
  //    return (pBottom >= height || pBottom + spd > oTop && pTop < oTop && pRight > oLeft && pLeft < oRight);
  //  } else if (dir % 4 == 0) {
  //    return (pLeft <= 0 || pLeft - spd < oRight && pRight > oRight && pBottom > oTop && pTop < oBottom);
  //  } else {
  //    return false;  
  //  }
  //}
  
  public boolean cannotGoObsts(obstacle o, int dir) { // 1 = N, 2 = E, 3 = S, 4 = W
    float nextLeft = pos.x;
    float nextRight = pos.x + 50;
    float nextTop = pos.y;
    float nextBottom = pos.y + 50;
    float oLeft = o.pos.x;
    float oRight = o.pos.x + o.w;
    float oTop = o.pos.y;
    float oBottom = o.pos.y + o.h;
    
    if (dir == 1) { 
      nextTop -= spd;
      nextBottom -= spd;
    } else if (dir == 2) { 
      nextLeft += spd;
      nextRight += spd;
    } else if (dir == 3) { 
      nextTop += spd;
      nextBottom += spd;
    } else if (dir == 4) { 
      nextLeft -= spd;
      nextRight -= spd;
    }
    
    return !(nextRight <= oLeft || nextLeft >= oRight || nextBottom <= oTop || nextTop >= oBottom);
  }

  
  public boolean cannotGoBorder(int dir) {
    if (dir == 1) {
      return pos.y <= 0;
    }
    if (dir == 2) {
      return pos.x + 50 >= width;
    }
    if (dir == 3) {
      return pos.y + 50 >= height;
    }
    if (dir == 4) {
      return pos.x <= 0;
    }
    return false;
  }
  
    public boolean cannotGoes(room r, int dir) {
    if (r.obstacles.size() == 0) {
      return cannotGoBorder(dir);
    }
    for (obstacle o : r.obstacles) {
      if (cannotGoObsts(o, dir) || cannotGoBorder(dir)) {
        return true;
      }
    }
      return false;
  }
  
  public boolean inRange(entity other, int range) {
    float closeX = (other.pos.x + 25) - (this.pos.x + 25);
    float closeY = (other.pos.y + 25) - (this.pos.y + 25);
    return closeX * closeX + closeY * closeY <= range * range;
  }
  
  public void move(room r) {
    if (!cannotGoes(r, this.dir)) {
      if (dir == 1) {
        pos.y -= spd;
      }
      if (dir == 2) {
        pos.x += spd;
      }
      if (dir == 3) {
        pos.y += spd;
      }
      if (dir == 4) {
        pos.x -= spd;
      }
    }
  }

}
