
Circle circle1;
Circle circle2;

void setup()
{
  size(300, 300);
  smooth();
  ellipseMode(RADIUS);
  rectMode(CENTER);
  
  circle1 = new Circle(100, 100, 50);
  circle2 = new Circle(150, 150, 60);
}

void draw()
{
}

void mouseMoved()
{
  background(128);
  
  circle1.setCentre(mouseX, mouseY);
  
  stroke(0);
  noFill();
  circle1.draw();
  circle2.draw();
  
  noStroke();
  fill(255,0,0,200);

  PVector[] arr = intersect(circle1, circle2);
  
  for (int n = 0; n < arr.length; ++n)
  {
    rect(arr[n].x, arr[n].y, 10, 10);
  }
}


