class player extends entity {
  
  ArrayList<String> inventoryNames;
  ArrayList<Integer> inventoryQuantities;
  
  public player(String name, int hp, int atk, PVector pos, ArrayList<String> inventoryNames, ArrayList<Integer> inventoryQuantities) {
    super(name, hp, atk, pos);
    this.inventoryNames = inventoryNames;
    this.inventoryQuantities = inventoryQuantities;
  }
  
  
}
