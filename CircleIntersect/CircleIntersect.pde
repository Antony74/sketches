
CircleIntersector circleIntersector;

void setup()
{
  size(300, 300);
  ellipseMode(RADIUS);
  rectMode(CENTER);
  
  circleIntersector = new CircleIntersector(new PVector(100,100), 50, new PVector(150,150), 60);
}

void draw()
{
}

void mouseMoved()
{
  background(128);
  
  circleIntersector.pvCentre1.x = mouseX;
  circleIntersector.pvCentre1.y = mouseY;
  
  stroke(0);
  noFill();
  circleIntersector.draw();
  
  noStroke();
  fill(255,0,0,200);
  float heading = circleIntersector.getHeading();
  PVector2D pv1 = (PVector2D)veryLazyHillClimber(new PVector2D(heading, heading + HALF_PI, 0.02, 0.02), circleIntersector);
  PVector2D pv2 = (PVector2D)veryLazyHillClimber(new PVector2D(heading, heading - HALF_PI, 0.02, 0.02), circleIntersector);
  
  float fitness = circleIntersector.evaluate(pv1);
  
//  println(fitness);
  
  if (fitness <= 16)
  {  
    PVector pvCart1 = circleIntersector.toCartesian1(pv1);
    PVector pvCart2 = circleIntersector.toCartesian1(pv2);

    rect(pvCart1.x, pvCart1.y, 10, 10);
    rect(pvCart2.x, pvCart2.y, 10, 10);
  }
}

class CircleIntersector implements FitnessEvaluator<PVector2D>
{
  CircleIntersector(PVector pvCentre1, float radius1, PVector pvCentre2, float radius2)
  {
    this.pvCentre1 = pvCentre1.get();
    this.radius1 = radius1;
    this.pvCentre2 = pvCentre2.get();
    this.radius2 = radius2;
  }
  
  float evaluate(PVector2D pvParam)
  {
    PVector pv1 = toCartesian1(pvParam);
    PVector pv2 = toCartesian2(pvParam);
    
    pv2.sub(pv1);
    
    return pv2.magSq();
  }

  PVector toCartesian1(PVector pvTarget)
  {
    PVector pv1 = new PVector(radius1 * cos(pvTarget.x), radius1 * sin(pvTarget.x));
    pv1.add(pvCentre1);
    return pv1;
  }

  PVector toCartesian2(PVector pvTarget)
  {
    PVector pv2 = new PVector(radius2 * cos(pvTarget.y), radius2 * sin(pvTarget.y));
    pv2.add(pvCentre2);
    return pv2;
  }

  float getHeading()
  {
    PVector pv = PVector.sub(pvCentre1, pvCentre2);
    return pv.heading();
  }

  void draw()
  {
    ellipse(pvCentre1.x, pvCentre1.y, radius1, radius1);
    ellipse(pvCentre2.x, pvCentre2.y, radius2, radius2);
  }

  PVector pvCentre1;
  float radius1;
  PVector pvCentre2;
  float radius2;
};


