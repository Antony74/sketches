
float x(float paces) {
  return map(paces, 0, 8, 0, 300);
}

float y(float paces) {
  return map(paces, 0, 8, 300, 0);
}

void setup() {
  size(600, 600);
}

void draw() {

  translate(50, 250);
  strokeWeight(2);
  
  float xPace = abs(x(1) - x(0));
  float yPace = abs(y(1) - y(0));

  float fenceSection = 2.12 * xPace;
  float gate = 1.59 * xPace;
  
  // Patio
  fill(255, 255, 128);

  beginShape();
  vertex(x(0),  y(0));
  vertex(x(8),  y(0));
  vertex(x(8),  y(5));
  vertex(x(10), y(5));
  vertex(x(10), y(6));
  vertex(x(0), y(6));
  endShape(CLOSE);

  // Non-patio, currently grassed
  fill(0, 192, 0);
  
  beginShape();
  vertex(x(0),  y(6));
  vertex(x(10), y(6));
  vertex(x(10), y(5));
  vertex(x(13), y(5));
  vertex(x(13), y(13));
  vertex(x(0),  y(14));
  endShape(CLOSE);
  
  // Bush
  ellipseMode(RADIUS);
  fill(0, 128, 0);
  arc(x(0), y(14), 1.5 * xPace, 1.5 * yPace, 0.1, HALF_PI, PIE);
  
  // Water butt
  ellipseMode(CORNER);
  fill(0, 128, 0);
  ellipse(x(9), y(5), 1.5 * xPace, -1.5 * yPace);
  
  // Arbour
  pushMatrix();
  translate(x(9), y(13));
  rotate(0.1);
  fill(0, 255, 255);
  rect(0, 0, 3 * xPace, 2 * yPace);
  popMatrix();
  
  // Backdoor
  float doorThickness = 0.3;
  fill(255);
  rect(x(2), y(0) - 0.5*doorThickness*yPace, 4 * xPace, doorThickness * yPace);
  
  // Garage door
  fill(255);
  rect(x(8) - 0.5*doorThickness*xPace, y(1), doorThickness * xPace, -2.5 * yPace);
 
  // Fence
  strokeWeight(5);
 
  float xPos = x(13);
  float yPos = y(8);
  
  for (int n = 0; n < 3; ++n) {

    xPos -= fenceSection;

    stroke(165,42,42);
    line(xPos, yPos, xPos + fenceSection, yPos); 

    stroke(255);
    point(xPos, yPos);
    point(xPos + fenceSection, yPos);
  }
  
  noLoop();
}