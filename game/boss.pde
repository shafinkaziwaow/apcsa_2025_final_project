class boss extends enemy {
  
  entity bossSword;
  entity bossProjectile;
  float atkAng;
  
  public boss(String name, int hp, int maxHP, int atk, PVector pos, int dir, int range, int atkCoolDown) {
    super(name, hp, maxHP, atk, pos, dir, range, atkCoolDown);
    this.bossSword = new entity("sword", 0, 0, 0, new PVector(this.pos.x, this.pos.y), 1);
    this.bossProjectile = new entity("projectile", 0, 0, 0, new PVector(this.pos.x, this.pos.y), 1);
    this.atkAng = 0;
  }
  
}
