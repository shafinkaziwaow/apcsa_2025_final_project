class player extends entity {
  //int width = 1550;
  //int height = 875;
  int width = 900;
  int height = 700;
  ArrayList<String> inventoryNames;
  ArrayList<Integer> inventoryQuantities;
  boolean isPaused;
  int exp; 
  int expToNextLevel; 
  int level;
  
  public player(String name, int hp, int maxHP, int atk, PVector pos, ArrayList<String> inventoryNames, ArrayList<Integer> inventoryQuantities, int exp, int expToNextLevel, int level) {
    super(name, hp, maxHP, atk, pos, 1);
    this.inventoryNames = inventoryNames;
    this.inventoryQuantities = inventoryQuantities;
    this.atkCoolDown = 0;
    this.isPaused = false;
    this.exp = exp;
    this.expToNextLevel = expToNextLevel;
    this.level = level;
  }
  
  public void addExp(int expGained) {
    if (expGained + exp >= expToNextLevel) {
      level++;
      atk *= 1.33; 
      maxHP += 25;
      hp = maxHP;
      exp = exp + expGained - expToNextLevel;
      expToNextLevel += 50;
    } else {
      exp += expGained;
    }
  }
    
}
