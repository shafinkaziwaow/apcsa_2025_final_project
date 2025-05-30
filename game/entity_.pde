
class entity {

  String name;
  int hp;
  PVector pos;
  int atk;
  int ticks;
  
  
  public entity(String name, int hp, int atk, PVector pos) {
    this.name = name;
    this.hp = hp;
    this.atk = atk;
    this.pos = pos;
    this.ticks = 1;
  }
  
  public void attack(entity other) {
    other.hp -= this.atk;  
  }
  
    public boolean cannotGoObsts(obstacle o, int dir) { // 1 == N, 2 == E, 3 == S, 4 == W
    // makes things easier
    float pLeft = pos.x;
    float pRight = pos.x + 50;
    float pTop = pos.y;
    float pBottom = pos.y + 50;
    float oLeft = o.pos.x;
    float oRight = o.pos.x + o.w;
    float oTop = o.pos.y;
    float oBottom = o.pos.y + o.h;
    
    if (dir % 4 == 1) {
      return (pTop <= 0 || pTop <= oBottom && pBottom > oBottom && pRight > oLeft && pLeft < oRight);
    } else if (dir % 4 == 2) {
      return (pRight >= width || pRight >= oLeft && pLeft < oLeft && pBottom > oTop && pTop < oBottom);
    } else if (dir % 4 == 3) {
      return (pBottom >= height || pBottom >= oTop && pTop < oTop && pRight > oLeft && pLeft < oRight);
    } else if (dir % 4 == 0) {
      return (pLeft <= 0 || pLeft <= oRight && pRight > oRight && pBottom > oTop && pTop < oBottom);
    } else {
      return false;  
    }
  }
  
  public boolean cannotGoBorder(int dir) {
    if (dir % 4 == 1) {
      return pos.y <= 0;
    }
    if (dir % 4 == 2) {
      return pos.x + 50 >= width;
    }
    if (dir % 4 == 3) {
      return pos.y + 50 >= height;
    }
    if (dir % 4 == 0) {
      return pos.x <= 0;
    }
    return false;
  }
  
    public boolean cannotGoes(room r, int dir) {
    boolean returning = false;
    if (r.obstacles.size() == 0) {
      return cannotGoBorder(dir);
    }
    for (obstacle o : r.obstacles) {
      if (cannotGoObsts(o, dir)) {
        returning = true;
        break;
      }
    }
      return returning;
  }
  
  public void move(int spd) {
    int dir = 0;
    if (ticks % 20 == 0) {
      dir = (int) (Math.random() * 4) + 1; 
    } 
    else {
      if (dir % 4 == 1) {
        this.pos.y -= spd;
      }
      if (dir % 4 == 2) {
        this.pos.x += spd;
      }
      if (dir % 4 == 3) {
        this.pos.y += spd;
      }
      if (dir % 4 == 0) {
        this.pos.x -= spd;
      }
      ticks++;
    }
  }

}
