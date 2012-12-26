
void drawArrows(RShapeIterator itr)
{
  strokeWeight(1);
  rectMode(CORNER);

  drawArrow(140, -20, PI,       itr.hasPrevious(), keyPressed && (keyCode == LEFT));  // Left
  drawArrow(180, -20, HALF_PI,  itr.hasDown(),     keyPressed && (keyCode == DOWN));  // Down
  drawArrow(220, -20, 0,        itr.hasNext(),     keyPressed && (keyCode == RIGHT)); // Right
  drawArrow(180, -60, -HALF_PI, itr.hasUp(),       keyPressed && (keyCode == UP));    // Up
}

void drawArrow(float x, float y, float angle, boolean enabled, boolean pressed)
{
  pushMatrix();
  translate(x, y);
  rotate(angle);

  if (pressed)
  {
    fill(128);
    stroke(0);
  }
  else if (enabled)
  {
    noFill();
    stroke(0);
  }
  else
  {
    noFill();
    stroke(128);
  }
  
  rect( -15, -15, 30, 30);

  if (pressed)
  {
    fill(0);
    stroke(0);
  }
  else if (enabled)
  {
    fill(128);
    stroke(0);
  }
  else
  {
    noFill();
    stroke(128);
  }
  	
  beginShape();
  vertex( -12,  -3);
  vertex(   0,  -3);
  vertex(   0,  -6);
  vertex(  12,   0);
  vertex(   0,   6);
  vertex(   0,   3);
  vertex( -12,   3);
  vertex( -12,  -3);
  endShape();
  
  popMatrix();
}

