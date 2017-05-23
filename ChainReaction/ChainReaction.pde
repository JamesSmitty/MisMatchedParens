Ball[] balls;
boolean reactionStarted;

void setup() {
  size(600, 600);//set window size
  background(0);//set black background
  reactionStarted = false;
  balls = new Ball[25];
  for (int i=0; i < balls.length; i++) {//iterate through to fill array with balls
    balls[i] = new Ball();
  }
}

void draw() {
  background(0);
  if (reactionStarted) {
    for (Ball b : balls) {
      for (Ball r : balls) {
        if (r.getState() == 1) {//compare a given ball to all of the chain reaction balls
          if (b.distSquared(r) < pow((b.getRadius() + r.getRadius()), 2)) {//if their distance squared is less than the sum of the radii squared, then they are in contact
            b.setState(1);//since they touched, make it a chain reaction ball
          }
        }
      }
      if (b.getState() == 1) { //if the ball is a chain reaction ball..
        b.expandBall();//expand it by 'increase'
      }
    }
  }
  for (Ball b : balls) {
    b.draw();
    if (b.getState() == 0) {
      b.move();
    }
  }
}

void mouseClicked() {
  if (reactionStarted == false) {
    reactionStarted = true;
    Ball reactionBall = new Ball(255, 40, 0);//create a new special click ball
    reactionBall.setState(1);//set it to a chain reaction ball
    balls = (Ball[]) expand(balls, balls.length+1);//expand the balls array by 1(I know it is inefficient, but for the sake of the program, you are really only going to call it once
    balls[balls.length-1] = reactionBall;//insert the reactionBall into the last slot :)
  }
}