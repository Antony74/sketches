
void setup() {
  size(300, 300);
}

void draw() {
  int margin = 10;
  int initialSize = (int)(width * 1.1);
  background(200);
  noFill();
  strokeWeight(2);
  beginShape();
  doHilbert(margin, margin, initialSize - margin - margin - margin, 1, 2);
  endShape();

  noLoop();
}

void doHilbert(int x1, int y1, int size, int tile, int recurse) {
  int half_size = size / 2;
  int x2 = x1 + half_size;
  int y2 = y1 + half_size;
  if (recurse <= 0) {
    switch (tile) {
    case 1:
      vertex(x1, y1);
      vertex(x1, y2);
      vertex(x2, y2);
      vertex(x2, y1);
      break;
    case 2:
      vertex(x2, y2);
      vertex(x1, y2);
      vertex(x1, y1);
      vertex(x2, y1);
      break;
    case 3:
      vertex(x2, y2);
      vertex(x2, y1);
      vertex(x1, y1);
      vertex(x1, y2);
      break;
    case 4:
      vertex(x1, y1);
      vertex(x2, y1);
      vertex(x2, y2);
      vertex(x1, y2);
      break;
    }
  } else {
    switch (tile) {
    case 1:
      doHilbert(x1, y1, half_size, 4, recurse - 1);
      doHilbert(x1, y2, half_size, 1, recurse - 1);
      doHilbert(x2, y2, half_size, 1, recurse - 1);
      doHilbert(x2, y1, half_size, 2, recurse - 1);
      break;
    case 2:
      doHilbert(x2, y2, half_size, 3, recurse - 1);
      doHilbert(x1, y2, half_size, 2, recurse - 1);
      doHilbert(x1, y1, half_size, 2, recurse - 1);
      doHilbert(x2, y1, half_size, 1, recurse - 1);
      break;
    case 3:
      doHilbert(x2, y2, half_size, 2, recurse - 1);
      doHilbert(x2, y1, half_size, 3, recurse - 1);
      doHilbert(x1, y1, half_size, 3, recurse - 1);
      doHilbert(x1, y2, half_size, 4, recurse - 1);
      break;
    case 4:
      doHilbert(x1, y1, half_size, 1, recurse - 1);
      doHilbert(x2, y1, half_size, 4, recurse - 1);
      doHilbert(x2, y2, half_size, 4, recurse - 1);
      doHilbert(x1, y2, half_size, 3, recurse - 1);
      break;
    }
  }
}
