// All organisms appearing in this work are fictitious.
// Any resemblance to actual biology is purely coincidental! ;-)

Virus viruses[];
Cell cell;

void setup()
{
  size(900,600);
  smooth();

  viruses = new Virus[30];
  cell = new Cell();

  for (int n = 0; n < viruses.length; ++n)
  {
    viruses[n] = new Virus();
    viruses[n].position.x = random(width);
    viruses[n].position.y = random(height);
    viruses[n].velocity.x = random(-0.2,0.2);
    viruses[n].velocity.y = random(-0.2,0.2);
    viruses[n].orientation = random(TWO_PI);
    viruses[n].rotation = random(-0.01, 0.01);
  }
}

void draw()
{
  background(0,128,0);
  
  //
  // Draw viruses
  //

  strokeWeight(1);
  stroke(32,128);
  fill(32,128);

  for (int n = 0; n < viruses.length; ++n)
  {
    viruses[n].move();
    viruses[n].draw();
  }

  //
  // Draw cell
  //
  
  strokeWeight(5);
  stroke(255);
  fill(128);
  
  cell.move();
  cell.draw();
}

class Virus
{
  PVector position = new PVector();
  PVector velocity = new PVector();
  float orientation;
  float rotation;

  void draw()
  {
    pushMatrix();
    translate(position.x, position.y - 20);
    rotate(orientation);
    drawBacteriophage();
    popMatrix();
  }

  void move()
  {
    position.x += velocity.x;
    position.y += velocity.y;
    orientation += rotation;
  }
    
  void drawBacteriophage()
  {
    float xCentre = 0;
    float yHead   = -35;
    float headRadius = 15;
    float yBottom = 0;
    float tailWidth = 5;
    float yFibreStart = -7.5;
    float xToFibreTop = 7.5;
    float yFibreTop = -15;
    float xToFibreEnd = 15;
  
    drawBacteriophage(xCentre, yHead, headRadius, yBottom, tailWidth, yFibreStart, xToFibreTop, yFibreTop, xToFibreEnd);
  }
  
  void drawBacteriophage(float xCentre, float yHead, float headRadius, float yBottom, float tailWidth, float yFibreStart, float xToFibreTop, float yFibreTop, float xToFibreEnd)
  {
    // Draw right tail fibre
    line(xCentre, yFibreStart, xCentre + xToFibreTop, yFibreTop);
    line(xCentre + xToFibreTop, yFibreTop, xCentre + xToFibreEnd, yBottom);
  
    // Draw left tail fibre
    line(xCentre, yFibreStart, xCentre - xToFibreTop, yFibreTop);
    line(xCentre - xToFibreTop, yFibreTop, xCentre - xToFibreEnd, yBottom);
  
    // Draw tail
    triangle(xCentre - (tailWidth/2), yHead, xCentre + (tailWidth/2), yHead, xCentre, yBottom);
    
    // Draw head
    ellipse(xCentre, yHead, headRadius, headRadius);
  }
};

class Cell
{
  int vertices = 15;
  PVector position[];
  PVector velocity[];
  PVector centre = new PVector();
  float area;

  final float hookesConstant = 0.00013;
  final float pressureConstant = 500;
  final float initialRadius = 200;
    
  Cell()
  {
    position = new PVector[vertices];
    velocity = new PVector[vertices];

    float baseVelocityX = 0;
    float baseVelocityY = 0;
    
    for (int n = 0; n < vertices; ++n)
    {
      position[n] = new PVector();
      velocity[n] = new PVector();

      position[n].x = (width * 0.5)  + (initialRadius * cos(TWO_PI * n / (vertices-1)));
      position[n].y = (height * 0.5) + (initialRadius * sin(TWO_PI * n / (vertices-1)));
      velocity[n].x = baseVelocityX + random(-0.2,0.2);
      velocity[n].y = baseVelocityY + random(-0.2,0.2);
    }
  }

  void draw()
  {
    beginShape();
    for (int n = 0; n < vertices; ++n)
    {
      curveVertex(position[n].x, position[n].y);
    }    
    curveVertex(position[0].x, position[0].y);
    curveVertex(position[1].x, position[1].y);
    curveVertex(position[2].x, position[2].y);
    endShape();
  }

  float twiceTriangleArea(float x1, float y1, float x2, float y2, float x3, float y3)
  {
    return abs( ((x1*(y2-y3)) + (x2*(y3-y1)) + (x3*(y1-y2))) );
  }

  void updateCentreAndArea()
  {
    centre.x = 0;
    centre.y = 0;
    area = 0;
    
    for (int n = 0; n < vertices; ++n)
    {
      centre.x += position[n].x;
      centre.y += position[n].y;
    }
  
    centre.x /= vertices;
    centre.y /= vertices;

    // Calculate area (assumes the cell wall stays reasonably well behaved)
    for (int n = 0; n < vertices; ++n)
    {
      int nNext = (n + 1) % vertices;
      area += twiceTriangleArea(centre.x,centre.y,position[n].x,position[n].y,position[nNext].x,position[nNext].y);
    }

    area /= 2;
  }

  void move()
  {
    updateCentreAndArea();
    
    for (int n = 0; n < vertices; ++n)
    {
      // Newton's first law of motion
      position[n].x += velocity[n].x;
      position[n].y += velocity[n].y;
      
      int nNext = (n + 1) % vertices;

      // Hooke's law
      float xForce = hookesConstant * (position[n].x - position[nNext].x);
      float yForce = hookesConstant * (position[n].y - position[nNext].y);
      
      velocity[n].x -= xForce;
      velocity[n].y -= yForce;
      velocity[nNext].x += xForce;
      velocity[nNext].y += yForce;
    }
    
    // Something a bit like pressure
    float force = pressureConstant / area;
    for (int n = 0; n < vertices; ++n)
    {
      float distance = dist(centre.x, centre.y, position[n].x, position[n].y);
      velocity[n].x += (position[n].x - centre.x) * force / distance;
      velocity[n].y += (position[n].y - centre.y) * force / distance;
    }
  }
    
};


