
float x(float paces) {
  return map(paces, 0, 8, 0, 500);
}

float y(float paces) {
  return map(paces, 0, 8, 500, 0);
}

void setup() {
  size(800, 600);
}

void draw() {

  translate(50, 50);
  line(x(0), y(0), x(8), y(0));

  noLoop();
}