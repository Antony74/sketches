ArrayList<Polygon> testPolys = new ArrayList<Polygon>();
ArrayList<Mover> movers = new ArrayList<Mover>();
int polySides = 3;
int nMovers = 200;
int moverRadius = 4;
color bgColor = color(255, 255, 200);

class PolygonPoints {
  ArrayList<PVector> arr = new ArrayList<PVector>();

  PolygonPoints add(float x, float y) {
    arr.add(new PVector(x, y));
    return this;
  }
}

Polygon createArrowHeadedTriangle(float x, float y, float halfWidth, float halfHeight) {
    return new Polygon(new PolygonPoints()
      .add(x - halfWidth, y + halfHeight)
      .add(x, y - halfHeight)
      .add(x + halfHeight, y + halfHeight)
      .add(x, y + (0.5 * halfHeight)).arr
   );
}

void setup() {
  size(900, 900, P3D);
  smooth(8);
  background(255, 255, 200);
  ellipseMode(RADIUS);
  
  testPolys.add(new Polygon(getPolyPoints(200, 200, 3, 100)));
  testPolys.add(new Polygon(getPolyPoints(700, 300, 5, 100)));
  testPolys.add(new Polygon(getPolyPoints(width / 2, height / 2, 6, 125)));
  testPolys.add(new Polygon(getPolyPoints(200, 700, 20, 150)));

  testPolys.add(createArrowHeadedTriangle(700, 700, 150, 150));
  testPolys.add(createArrowHeadedTriangle(700, 700, 60, 60).setColor(255, 255, 200));

  for (int i = 0; i < nMovers; i++) {
    PVector pos = new PVector(random(moverRadius, width - moverRadius), random(moverRadius, height - moverRadius));

    float x = random(-1, 1);
    float y = random(-1, 1);
    
    x += sign(x);
    y += sign(y);
    
    PVector velocity = new PVector(x, y);
    movers.add(new Mover(moverRadius, pos, velocity));
  }
}

void draw() {
  background(bgColor);
  runDemo();
  println(frameCount / 60);
}

ArrayList<PVector> getPolyPoints(float x, float y, float sides, float radius) {
  ArrayList<PVector> polyPoints = new ArrayList<PVector>();
  for (int i = 0; i < sides; i++) {
    float px = x + radius * cos(i * 2 * PI / sides);
    float py = y + radius * sin(i * 2 * PI / sides);
    polyPoints.add(new PVector(px, py));
  }
  return polyPoints;
}

void runDemo() {
  strokeWeight(1);
//  PVector mouseV = new PVector(mouseX, mouseY);
  for (Mover m : movers) {
    int contained = 0;
    for (Polygon poly : testPolys) {
      if (poly.contains(m.pos)) {
        ++contained;
      }
    }
    m.move();
    m.fillColor = (contained % 2 == 1) ? color(255, 0, 0) : color(0, 0, 255);
  }
  
  for (Polygon poly : testPolys) {
    fill(poly.polygonColor);
    poly.show();
  }
  for (Mover m : movers) {
    m.show();
  }
  drawMouse();
}

void drawMouse() {
  strokeWeight(4);
  line(mouseX - 10, mouseY, mouseX + 10, mouseY);
  line(mouseX, mouseY - 10, mouseX, mouseY + 10);
}

class Polygon {
  
  ArrayList<PVector> points;
  color polygonColor;
  
  Polygon(ArrayList<PVector> list) {
    this.points = list;
    this.polygonColor = color(255);
  }
  
  Polygon setColor(int r, int g, int b) {
    this.polygonColor = color(r, g, b);
    return this;
  }
  
  // ray-casting test for containment: https://en.wikipedia.org/wiki/Point_in_polygon#Ray_casting_algorithm
  boolean contains(PVector p) {
    PVector rayEnd = new PVector(width * 10, height * 10);
    int intersections = 0;
    for (int i = 0; i < points.size(); i++) {
      PVector a = points.get(i);
      PVector b = points.get((i + 1) % points.size());
      if (intersect(a, b, p, rayEnd)) {
        intersections++;
      }
    }
    return intersections % 2 == 1;
  }
  
  void show() {
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }
  
  void show(color fillColor) {
    fill(fillColor);
    show();
  }
  
}

// line segment AB intersects line segment CD, see: https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection#Given_two_points_on_each_line
boolean intersect(PVector a, PVector b, PVector c, PVector d) {
  float tNom = (a.x - c.x) * (c.y - d.y) - (a.y - c.y) * (c.x - d.x);
  float tDenom = (a.x - b.x) * (c.y - d.y) - (a.y - b.y) * (c.x - d.x);
  float uNom = (a.x - c.x) * (a.y - b.y) - (a.y - c.y) * (a.x - b.x);
  float uDenom = (a.x - b.x) * (c.y - d.y) - (a.y - b.y) * (c.x - d.x);
  return abs(tNom) < abs(tDenom) && sign(tNom) == sign(tDenom) && abs(uNom) < abs(uDenom) && sign(uNom) == sign(uDenom);
}

int sign(float x) {
  return x == 0 ? 0 : (x > 0 ? 1 : -1);
}

class Mover {
  
  int radius;
  PVector pos; 
  PVector v;
  color fillColor;
  
  Mover(int radius, PVector pos, PVector v) {
    this.radius = radius; this.pos = pos; this.v = v;
  }
  
  void move() {
    if (pos.x - radius < 0 || pos.x + radius > width) {
      v.x = -v.x;
    }
    if (pos.y - radius < 0 || pos.y + radius > height) {
      v.y = -v.y;
    }
    this.pos.add(v);
  }
  
  void show() {
    fill(fillColor);
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  void die() {
    v = new PVector(0, 0);
  }
  
}
