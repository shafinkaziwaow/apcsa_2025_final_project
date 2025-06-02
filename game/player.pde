class player extends entity {
  //int width = 1550;
  //int height = 875;
  int width = 900;
  int height = 700;
  ArrayList<String> inventoryNames;
  ArrayList<Integer> inventoryQuantities;
  boolean isPaused;
  
  public player(String name, int hp, int atk, PVector pos, ArrayList<String> inventoryNames, ArrayList<Integer> inventoryQuantities) {
    super(name, hp, atk, pos);
    this.inventoryNames = inventoryNames;
    this.inventoryQuantities = inventoryQuantities;
    this.atkCoolDown = 0;
    this.isPaused = false;
  }
    
}
