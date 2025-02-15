
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
  color yellow = color(255, 255, 0);
  color brown = color(150, 70, 0);
  color yellowBrown = color(map(0.5, 0, 1, 150, 255), map(0.5, 0, 1, 70, 255), 0);
  color grey = color(100);
  color lightGrey = color(200);
  color lightGreen = color(128, 255, 128);
  color transparent = color(0, 0, 0, 0);

  textSize(13);
  background(lightGreen);

  int sleeperLength = 0;

  labelledRect("Existing bed", 0, 0, 100, 50, yellowBrown);
  labelledRect("Pot slab", 0, 50 + bedLength + 20, 50, 50, grey);
  
  labelledRect("", 50, 50, 20, 240, brown);
  sleeperLength += 240;
  
  labelledRect("", 0, 50 + bedLength, 70, 20, brown);
  sleeperLength += 70;
  
  int longCut = bedLength - 240;
  labelledRect("", 50, 50 + 240, 20, longCut, brown);
  sleeperLength += longCut;

  float sleepersUsed = (float)sleeperLength / 240.0;
  sleepersUsed *= 2.0;

  labelledRect("Patio", 0, 50 + bedLength + 20 + 50, 300, 200, lightGrey);

  labelledRect("Scale 1 meter", 100, 100, 100, 25, transparent);
  fill(lightGreen);
  noStroke();
  rect(100, 100, 105, 10);
  
  labelledRect("Bed", 0, 50, 50, bedLength, yellow);
  
  fill(0);
  text("Sleepers used: " + nf(sleepersUsed, 0, 2), 100, 170);
  
  float bedVolume = metersCubed(bedLength, 50, 20);
  text("Bed volume: " + bedVolume + "m³", 100, 210);
  
  text("Density of dry sand: ~1600 kg/m³", 100, 255);
  
  text("Sand to brim: " + (bedVolume * 1600) + "kg", 100, 300);
  
  save("Garden plan.png");
}
