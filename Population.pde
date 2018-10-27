class Population {
  Dot[] dots;
  
  public Population(int num) {
    this.dots = new Dot[num];
  }
  
  public Population(int num, int movesPerDot, int startx, int starty) {
    this.dots = new Dot[num];
    for(int i = 0; i < num; i++) {
      dots[i] = new Dot(movesPerDot, startx, starty); 
    }
  }
  
}
