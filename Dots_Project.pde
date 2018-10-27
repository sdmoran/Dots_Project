//Controller class for dots.   
import java.lang.Math;
import java.util.*;

Dot bestPopDot;
int thisAvg = 0;
int bestAvg = 0;
Population bestPop;
int xgoal = 400;
int ygoal = 0;
int startx = 400;
int starty = 750;
int dotNum = 50;
static final int H_DIM = 800;
static final int V_DIM = 800;
static final int MOVES = 400;
int gens = 20;
int[] averages = new int[gens];
int currentGen = 0;

//Dot d = new Dot(100, 320, 180);
Population p = new Population(dotNum, MOVES, startx, starty);

void setup() {
  size(800, 800);
  fill(255);
}

void keyPressed() {
  loop(); 
}

void draw() {
  background(255);
  for(int i = 0; i < p.dots.length; i++) {
    p.dots[i].update();
    if(p.dots[i].x > 800 || p.dots[i].x <= 0 || p.dots[i].y > 800 || p.dots[i].y <= 0 || p.dots[i].moveNum == MOVES - 1) {
      p.dots[i].setDead();
    }
    fill(255);
    ellipse(p.dots[i].x, p.dots[i].y, 4, 4);
    rect(xgoal - 5, ygoal, 10, 2);
    println ("Dot " + i + ": " + p.dots[i].isDead); 
  }
  boolean allDead = true;
  for(int i = 0; i < p.dots.length; i++) {
    if(!p.dots[i].isDead) {
      allDead = false;
    }
  }
  
  if(allDead) {
    println("ALL DEAD");
  
    int bestDot = 0;
    int bestScore = 0;
    int totalScore = 0;
    for(int i = 0; i < p.dots.length; i++) {
      int thisScore = calculateScore(p.dots[i]);
      totalScore += thisScore;
      println("Dot " + i + ": " + thisScore);
      if(thisScore > bestScore) {
        bestScore = thisScore;
        bestDot = i;
      }
    }
    
    int thisAvg = totalScore/dotNum;
    println("Best score: " + bestScore + " by dot " + bestDot);
    println("Average score: " + thisAvg);
    
    if(thisAvg >= bestAvg) {
      bestAvg = thisAvg;
      bestPopDot = p.dots[bestDot];
    }
    
    p = breed(bestPopDot);
    
    if(currentGen < gens) {
      averages[currentGen] = thisAvg;
      currentGen++;
    }
    
    else {
      noLoop();
      for(int i = 0; i < gens; i++) {
        println("Gen " + i + " average: " + averages[i]);
      }
    }
  }
}

int calculateScore(Dot d) {
   int score = 1000 - d.y - (xgoal - d.x);
   return score;
}

Population breed(Dot d) {
   Population pop = new Population(dotNum); 
   for(int i = 0; i < dotNum; i++) {
      pop.dots[i] = new Dot(d, MOVES, startx, starty);
   }
   return pop;
}
