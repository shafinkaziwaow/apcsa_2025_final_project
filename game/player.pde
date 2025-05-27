class player extends entity {
  
  ArrayList<String> inventoryNames;
  ArrayList<Integer> inventoryQuantities;
  
  public player(String name, int hp, int atk, PVector pos, ArrayList<String> inventoryNames, ArrayList<Integer> inventoryQuantities) {
    super(name, hp, atk, pos);
    this.inventoryNames = inventoryNames;
    this.inventoryQuantities = inventoryQuantities;
  }
  
  public boolean cannotGo(obstacle o, int dir) { // 1 == N, 2 == E, 3 == S, 4 == W
      if (dir == 1) {
        return (pos.y > o.pos.y + o.h && pos.x + 50 <= o.pos.x + o.w && pos.x >= o.pos.x); // y is above the lower bound of obj, and between its width
      } else if (dir == 2) {
        return (pos.x >= o.pos.x - 50 && pos.y >= o.pos.y && pos.y + 50 <= o.pos.y + o.h);
      } else if (dir == 3) {
        return (pos.y + 50 >= o.pos.y + o.h && pos.x + 50 >= o.pos.x + o.w && pos.x <= o.pos.x);
      } else {
        return (pos.x <= o.pos.x + o.w && pos.y <= o.pos.y && pos.y + 50 >= o.pos.y + o.h);
      }
    }
    
}
