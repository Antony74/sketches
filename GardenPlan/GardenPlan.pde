
void labelledRect(String label, float x, float y, float w, float h, color c) {
  push();
  stroke(0);

  if (alpha(c) == 0) {
    noFill();
  } else {
    fill(c);
  }
  rect(x, y, w, h);
  fill(0);
  text(label, x + 5, y + 20);
  pop();
}

float metersCubed(float xCm, float yCm, float zCm) {
  return (xCm / 100.0) * (yCm / 100.0) * (zCm / 100.0);
}

void setup() {
  size(300, 600);

  int bedLength = 355;
  int bedWidth = 50;
  
  int sleeperLength = 240;
  int sleeperWidth = 20;
  int sleeperHeight = 10;
  
  color yellow = color(255, 255, 0);
  color brown = color(150, 70, 0);
  color yellowBrown = color(map(0.5, 0, 1, 150, 255), map(0.5, 0, 1, 70, 255), 0);
  color grey = color(100);
  color lightGrey = color(200);
  color lightGreen = color(128, 255, 128);
  color transparent = color(0, 0, 0, 0);

  textSize(13);
  background(lightGreen);

  int requiredSleeperLength = 0;

  labelledRect("Existing bed", 0, 0, 100, 50, yellowBrown);
  labelledRect("Pot slab", 0, 50 + bedLength + sleeperWidth, 50, 50, grey);
  
  labelledRect("", 50, 50, sleeperWidth, sleeperLength, brown);
  requiredSleeperLength += sleeperLength;
  
  labelledRect("", 0, 50 + bedLength, 70, sleeperWidth, brown);
  requiredSleeperLength += 70;
  
  int longCut = bedLength - sleeperLength;
  labelledRect("", 50, 50 + sleeperLength, sleeperWidth, longCut, brown);
  requiredSleeperLength += longCut;

  float sleepersUsed = (float)requiredSleeperLength / sleeperLength;
  sleepersUsed *= 2.0;

  labelledRect("Patio", 0, 50 + bedLength + sleeperWidth + 50, 300, 200, lightGrey);

  labelledRect("Scale 1 meter", 100, 100, 100, 25, transparent);
  fill(lightGreen);
  noStroke();
  rect(100, 100, 105, 10);
  
  labelledRect("Bed", 0, 50, bedWidth, bedLength, yellow);
  
  fill(0);
  text("Sleepers used: " + nf(sleepersUsed, 0, 2), 100, 170);
  
  float bedVolume = metersCubed(bedLength, bedWidth, sleeperHeight + sleeperHeight);
  text("Bed volume: " + bedVolume + "m³", 100, 210);
  
  text("Density of dry sand: ~1600 kg/m³", 100, 255);
  
  text("Sand to brim: " + (bedVolume * 1600) + "kg", 100, 300);
  
  save("Garden plan.png");
}
