
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
    push();
    translate(getProductX(station, valueInCycle), getProductY());
    drawProduct(station, valueInCycle);
    pop();
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

void drawProduct(int station, int valueInCycle) {
  fill(0xff, 0xce, 0xb4);
  ellipse(0, 0, 200, 200);  

  float x = 35;
  float y = -30;
  
  int faceAlpha = 0;

  if (station > 1) {
    faceAlpha = 255;
  }
  
  push();
  translate(-x, y);
  drawEye(faceAlpha);
  pop();
  push();
  translate(x, y);
  drawEye(faceAlpha);
  pop();
}

void drawEye(int alpha) {
  float eyeWidth = 40;
  float eyeHeight = 20;
  float irisSize = 18;
  float pupilSize = 14;

  stroke(0, 0, 0, alpha);
  fill(255, 255, 255, alpha);
  ellipse(0, 0, eyeWidth, 20);
  fill(0, 255, 255, alpha);
  ellipse(0, 0, irisSize, irisSize);
}
