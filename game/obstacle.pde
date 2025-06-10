class obstacle {
  //int width = 1550;
  //int height = 875;
  int width = 900;
  int height = 700;
  int w;
  int h;
  PVector pos;
  color c;
  
  public obstacle(int w, int h, PVector pos, color c) {
    this.w = w;
    this.h = h;
    this.pos = pos;
    this.c = c;
  } 
  
  public obstacle(PVector pos, color c) {
    this.w = (int) random(400) + 100;
    this.h = (int) random(400) + 100;
    this.pos = pos;
    this.c = color(c);
  }
  
  public obstacle(color c) {
    this.w = 25 * ((int) Math.random() * 20);
    this.h = 25 * ((int) Math.random() * 20);
    //int posX = 25 * ((int) Math.random() * (width - w)) - 50;
    //int posY = 25 * ((int) Math.random() * (height - h)) - 50;
    //this.pos = new PVector(posX, posY);
    this.pos = new PVector(0, 0);
    this.c = c;
  }
  
}
