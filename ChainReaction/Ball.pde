class Ball {
  float x;
  float y;
  float rad;
  color c;
  float dx;
  float dy;
  int state; //0 = normal, 1 = chainball
  static final float increment = 0.1;//incrementation for chainballs
  static final int threshold = 30;//maximum radius size for chain reaction balls
  boolean expanded;//has it reached max size?

  Ball() {
    float r = random(256);
    float g = random(256);
    float b = random(256);
    c = color(r, g, b);
    rad = 10;
    x = random((width - r) + r/2);
    y = random((height - r) + r/2);
    dx = random(10)-5;
    dy = random(10)-5;
    state = 0;
    expanded = false;
  }

  Ball(float red, float green, float blue) {
    c = color(red, green, blue);
    rad = 10;
    x = mouseX;
    y = mouseY;
    state = 1;
    expanded = false;
  }

  void move() {
    x += dx;
    y += dy;
    bounce();
  }

  void draw() {
    ellipseMode(RADIUS);
    fill(c);//make the ball the color
    ellipse(x, y, rad, rad);//draw an ellipse at x, y, with radius rad
  }

  void bounce() {
    if (x<=0 || x >= width) {//if it contacts the sides, negate the x direction to reflect incident angle
      dx = -dx;
    }
    if (y <= 0 || y >= height) {//same but for top and bottom
      dy = -dy;
    }
  }

  void expandBall() {
    if (rad >= threshold && !expanded) {
      expanded = true;
    } else if (!expanded) {//if the radius is less than the threshold...
      rad += increment;
    } else {
      shrinkBall();
    }
  }

  void shrinkBall() {
    if (rad > 0) {
      rad -= increment;
    }
  }

  void setState(int x) {
    state = x;
  }

  void setExpanded(boolean t) {
    expanded = t;
  }

  float distSquared(Ball b) {//calculates the distance squared between the centers of two balls
    return pow((x-b.x), 2) + pow((y-b.y), 2);
  }

  int getState() {
    return state;
  }

  float getRadius() {
    return rad;
  }
}