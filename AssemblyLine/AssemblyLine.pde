
int cycleLength = 200; // The number of frames the product is at each station
int stations = 3; // The number of stations in this production line
int transits = stations + 2; // We want to see products moving between each station, plus on and off the screen

void setup() {
  size(900, 300);
}

void draw() {
  smooth();
  background(200);
  int valueInCycle = frameCount % cycleLength;
  
  drawConveyorBelt(getProductX(0, valueInCycle));
  
  // Draw a product at each station
  for (int station = 0; station < transits; ++station) {
    float position = (float)station + norm(valueInCycle, 0, cycleLength);
    pushMatrix();
    translate(getProductX(station, valueInCycle), getProductY());
    drawProduct(position);
    popMatrix();
  }

//  if (frameCount < cycleLength) {
//    saveFrame("frame-####.png");
//  }
}

float boundedMap(float value, float start1, float stop1, float start2, float stop2) {
  float value2 = norm(value, start1, stop1);
  if (value2 < 0) {
    return start2;
  } else if (value2 < 1) {
    return map(value, start1, stop1, start2, stop2);
  } else {
    return stop2;
  }
}

float conveyorBelt01(float value) {
  if (value < 0.2) {
    // Move to product to the current station
    return map(value, 0, 0.2, 0, 0.5);
  } else if (value < 0.8) {
    // Product is stationary at the station
    return 0.5;
  } else {
    // Move the product away to the next station
    return map(value, 0.8, 1, 0.5, 1);
  }
}

float conveyorBeltMap(float value, float start1, float stop1, float start2, float stop2) {
  float value2 = conveyorBelt01(norm(value, start1, stop1));
  return map(value2, 0, 1, start2, stop2);
}

float getProductX(int station, int valueInCycle) {
  float stationWidth = width / stations;
  float stationStart = map(station, 0, transits, -stationWidth, width + stationWidth);
  float x = conveyorBeltMap(valueInCycle, 0, cycleLength, stationStart, stationStart + stationWidth); 
  return x;
}

float getProductY() {
  return height / 2;
}

void drawConveyorBelt(float xOffset) {
  fill(32);
  stroke(64);
  strokeWeight(10);
  int slats = 10;
  float inset = height / 2;
  float stationWidth = width / stations;
  float slatsEnd = stationWidth * transits;
  
  for (int slat = 0; slat < slats; ++slat)
  {
    float xStart = map(slat, 0, slats, 0, slatsEnd) + xOffset;
    float xEnd = map(slat + 1, 0, slats, 0, slatsEnd) + xOffset;
    
    beginShape();
    vertex(xStart, height);
    vertex(xEnd, height);
    vertex(xEnd - inset, height - inset);
    vertex(xStart - inset, height - inset);
    endShape(CLOSE);
  }
}

void drawProduct(float position /* the whole number represents the station the product is at, the decimal represents how far through the station it is */) {

  // Draw a circle for the head
  stroke(0);
  strokeWeight(1);
  fill(0xff, 0xce, 0xb4);
  ellipse(0, 0, 200, 200);  

  float eyeX = 35;
  float eyeY = -30;
  
  // At station 1 on the assembly line (between 1.2 and 1.8) the eyes and mouth appear
  float faceAlpha = boundedMap(position, 1.2, 1.8, 0, 1);
  faceAlpha *= pow(faceAlpha, 1.5); // bend the way we fade in, because linear doesn't quite look right
  faceAlpha *= 255;
  
  // At station 2 the mouth is turned around
  float mouthRotation = boundedMap(position, 2.2, 2.8, 0, PI);

  // At station 3 the glasses go on
  float glassesY = boundedMap(position, 3.2, 3.8, -height * 0.7, eyeY);

  // Draw eyes
  pushMatrix();
  translate(-eyeX, eyeY);
  drawEye(faceAlpha);
  popMatrix();
  pushMatrix();
  translate(eyeX, eyeY);
  drawEye(faceAlpha);
  popMatrix();

  // Draw mouth
  pushMatrix();
  translate(0, 40);
  rotate(mouthRotation);
  drawMouth(faceAlpha);
  popMatrix();

  // Draw glasses
  pushMatrix();
  translate(0, glassesY);
  drawGlasses(35);
  popMatrix();
}

void drawEye(float alpha) {
  float eyeWidth = 40;
  float eyeHeight = 20;
  float irisSize = 18;
  float pupilSize = 6;

  stroke(0, 0, 0, alpha);
  fill(255, 255, 255, alpha);
  ellipse(0, 0, eyeWidth, eyeHeight);
  fill(0, 255, 255, alpha);
  ellipse(0, 0, irisSize, irisSize);
  fill(0, 0, 0, alpha);
  ellipse(1, 1, pupilSize, pupilSize);
}

void drawMouth(float alpha) {
  float adjustment = 0.2;
  
  noFill();
  stroke(255, 0, 0, alpha);
  strokeWeight(10);
  arc(0, 15, 70, 70, PI + adjustment, TWO_PI - adjustment);
}

void drawGlasses(float w) {
  float w2 = w * 2;
  float w3 = w * 3;
  fill(255, 128);
  stroke(0, 0, 0);
  strokeWeight(5);
  ellipse(-w, 0, w2, w2);
  ellipse( w, 0, w2, w2);
  line(-w2, 0, -w3, -w);
  line( w2, 0,  w3, -w);
}
