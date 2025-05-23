
class entity {

  String name;
  int hp;
  PVector pos;
  int atk;
  
  
  public entity(String name, int hp, int atk, PVector pos) {
    this.name = name;
    this.hp = hp;
    this.atk = atk;
    this.pos = pos;
  }
  
  public int getHP() {
    return hp;
  }
  
  public PVector getPos() {
    return pos;
  }
  
  public int getAtk() {
    return atk;
  }
  
  public void setHP(int hp) {
    this.hp = hp;
  }
  
  public void setPos(PVector pos) {
    this.pos = pos;
  }
  
  public void setAtk(int atk) {
    this.atk = atk;
  }
  
  public void attack(entity other) {
    other.setHP(other.getHP() - this.atk);  
  }

}
