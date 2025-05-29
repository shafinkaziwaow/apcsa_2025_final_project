class obstacle {
  int width = 1550;
  int height = 875;
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
    this.c = c;
  }
  
  public obstacle(color c) {
    this.w = (int) random(400) + 100;
    this.h = (int) random(400) + 100;
    int posX = (int) (Math.random() * (width - w));
    int posY = (int) (Math.random() * (height - h));
    this.pos = new PVector(posX, posY);
    this.c = c;
  }
  
}
