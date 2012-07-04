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

  Cell()
  {
    position = new PVector[vertices];
    velocity = new PVector[vertices];

    float baseVelocityX = -0.25;
    float baseVelocityY = -0.25;
    
    for (int n = 0; n < vertices; ++n)
    {
      position[n] = new PVector();
      velocity[n] = new PVector();

      position[n].x = (width * 0.5)  + (135 * cos(TWO_PI * n / (vertices-1)));
      position[n].y = (height * 0.5) + (135 * sin(TWO_PI * n / (vertices-1)));
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

  void move()
  {
    float xMin = position[0].x;
    float xMax = position[0].x;
    float yMin = position[0].y;
    float yMax = position[0].y;
    
    for (int n = 0; n < vertices; ++n)
    {
      // Newton's first law of motion
      position[n].x += velocity[n].x;
      position[n].y += velocity[n].y;
      
      // Add this point to the cell's minimum bounding rectangle
      xMin = min(xMin, position[n].x);
      xMax = max(xMax, position[n].x);
      yMin = min(yMin, position[n].y);
      yMax = max(yMax, position[n].y);
      
      int nNext = (n + 1) % vertices;

      // Hooke's law
      float xForce = 0.01 * (position[n].x - position[nNext].x);
      float yForce = 0.01 * (position[n].y - position[nNext].y);
      
      position[n].x -= xForce;
      position[n].y -= yForce;
      position[nNext].x += xForce;
      position[nNext].y += yForce;
    }
    
    float xForce = (xMax - xMin) - 400;
    float yForce = (yMax - yMin) - 400;
    
    xForce /= 200;
    yForce /= 200;
    
    float xCentre = (xMin + xMax) / 2;
    float yCentre = (yMin + yMax) / 2;
    
    for (int n = 0; n < vertices; ++n)
    {
      if (position[n].x > xCentre)
        position[n].x -= xForce;
      else
        position[n].y -= yForce;
        
      if (position[n].y > yCentre)
        position[n].y -= yForce;
      else
        position[n].y += yForce;
    }  
  }
};


