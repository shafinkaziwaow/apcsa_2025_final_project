class player extends entity {
  int width = 1550;
  int height = 875;
  ArrayList<String> inventoryNames;
  ArrayList<Integer> inventoryQuantities;
  
  public player(String name, int hp, int atk, PVector pos, ArrayList<String> inventoryNames, ArrayList<Integer> inventoryQuantities) {
    super(name, hp, atk, pos);
    this.inventoryNames = inventoryNames;
    this.inventoryQuantities = inventoryQuantities;
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
    
    if (dir == 1) {
      return (pTop <= 0 || pTop <= oBottom && pBottom > oBottom && pRight > oLeft && pLeft < oRight);
    } else if (dir == 2) {
      return (pRight >= width || pRight >= oLeft && pLeft < oLeft && pBottom > oTop && pTop < oBottom);
    } else if (dir == 3) {
      return (pBottom >= height || pBottom >= oTop && pTop < oTop && pRight > oLeft && pLeft < oRight);
    } else if (dir == 4) {
      return (pLeft <= 0 || pLeft <= oRight && pRight > oRight && pBottom > oTop && pTop < oBottom);
    } else {
      return false;  
    }
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
    boolean returning = false;
    if (r.obstacles.size() == 0) {
      return cannotGoBorder(dir);
    }
    for (obstacle o : r.obstacles ) {
      if (cannotGoObsts(o, dir)) {
        returning = true;
        break;
      }
    }
      return returning;
  }
    
}
