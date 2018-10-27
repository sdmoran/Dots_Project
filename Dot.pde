int MAXVEL = 4;
static final double VELINC = 3.0;

class Dot {
  Acceleration[] moves;
  int xvel;
  int yvel;
  int x;
  int y;
  int moveNum;
  boolean isDead = false;
  
  public Dot(int totalMoves, int x, int y) {
    this.moves = new Acceleration[totalMoves];
    this.x = x;
    this.y = y;
    for(int i = 0; i < totalMoves; i++) {
      moves[i] = new Acceleration((int) (VELINC * random(-1, 1)), (int) (VELINC * random(-1, 1)));
    }
    this.xvel = 0;
    this.yvel = 0;
    this.moveNum = 0;
  }
  
  //This is kinda weird. But takes the moves from the given dot and creates a new dot with moves based on the first dot. Yeah.
  public Dot(Dot d, int totalMoves, int x, int y) {
    this.moves = new Acceleration[totalMoves];
    for(int i = 0; i < totalMoves; i++) {
      this.moves[i] = mutate(d.moves[i]);
      //println(mutate(d.moves[i]).x + ", " + d.moves[i].y);
    }
    this.x = x;
    this.y = y;
    this.xvel = 0;
    this.yvel = 0;
    this.moveNum = 0;
  }
  
  void update() {
    if(moveNum < moves.length && !isDead) {
      x += xvel;
      y += yvel;
      xvel += moves[moveNum].x;
      yvel += moves[moveNum].y;
      moveNum++;
    }
    limitVelocity();
  }
  
  void limitVelocity() {
    if(xvel > MAXVEL) { xvel = MAXVEL; }
    if(yvel > MAXVEL) { yvel = MAXVEL; }
    if(xvel < -1 * MAXVEL) { xvel = -1 * MAXVEL; }
    if(yvel < -1 * MAXVEL) { yvel = -1 * MAXVEL; }
  }
  
  void setDead() {
    this.isDead = true;
  }
  
  Acceleration mutate(Acceleration a) {
    double coinFlip = random(0.0, 1.0);
    if(coinFlip >= 0.1)
      return a;
    else
      return new Acceleration((int) (VELINC * random(-1, 1)), (int) (VELINC * random(-1, 1)));
  }
}
