
void setup() {
  size(512, 800);
  background(0);

  // Star
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();

  for (float t = 0; t <= 1; t += 0.01) {
    star(
      pg,
      map(t, 0, 1, width * 0.4, width * 0.6),
      map(t, 0, 1, height * 0.3, height * 0.7),
      map(t, 0, 1, 60, 120),
      map(pow(t, 0.1), 0, 1, 255, 0)
    );
  }

  pg.endDraw();
  image(pg, 0, 0);
  filter(BLUR, 1.5);
  
  saveFrame("starshine.png");
}

void star(PGraphics pg, float x, float y, float radius, float alpha) {
  pg.push();
  pg.stroke(255, alpha);
  pg.fill(255, alpha);
  pg.translate(x, y);
  pg.beginShape();
  pg.rotate(HALF_PI);
  for (float angle = 0; angle <= 4*PI; angle += (4*PI) / 5) {
    pg.vertex(radius * cos(angle), radius * sin(angle));   
  }
  pg.endShape();
  pg.pop();
}
