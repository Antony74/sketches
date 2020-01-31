
int cycleLength = 5000;
int stations = 3;
int transits = stations + 2; // We want to see products moving between each station, plus on and off the screen

void setup() {
  size(900, 300);
}

void draw() {
  background(128);
  int valueInCycle = millis() % cycleLength;
  for (int station = 0; station < transits; ++station) {
    float position = (float)station + norm(valueInCycle, 0, cycleLength);
    push();
    translate(getProductX(station, valueInCycle), getProductY());
    drawProduct(position);
    pop();
  }
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
    return map(value, 0, 0.2, 0, 0.5);
  } else if (value < 0.8) {
    return 0.5;
  } else {
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

void drawProduct(float position /* the whole number represents the station the product is at, the decimal represents how far through the station it is */) {
  fill(0xff, 0xce, 0xb4);
  ellipse(0, 0, 200, 200);  

  float x = 35;
  float y = -30;
  
  // At station 1 on the assembly line (between 1.3 and 1.8) the eyes and mouth appear
  float faceAlpha = boundedMap(position, 1.3, 1.8, 0, 255);
  
  // At station 2 the mouth is turned around
  float mouthRotation = boundedMap(position, 2.3, 2.7, 0, PI);

  // At station 3 the glasses go on
  float glassesY = boundedMap(position, 3.3, 3.7, -height * 0.7, y);

  push();
  translate(-x, y);
  drawEye(faceAlpha);
  pop();
  push();
  translate(x, y);
  drawEye(faceAlpha);
  pop();
  
  push();
  translate(0, 40);
  rotate(mouthRotation);
  drawMouth(faceAlpha);
  pop();

  push();
  translate(0, glassesY);
  drawGlasses(35);
  pop();
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
