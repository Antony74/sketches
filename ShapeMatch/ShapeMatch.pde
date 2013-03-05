
import java.util.Random;

// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

ArrayList<RPoint> arrPoints;

void setup()
{
  size(900, 600);
  RG.init(this);
  
  arrPoints = new ArrayList<RPoint>();
  
  HeartProblem h = new HeartProblem();
  h.heart.draw();
}

void draw()
{
}

void mouseDragged()
{
  stroke(255, 0, 0);
  strokeWeight(2);
  line(pmouseX, pmouseY, mouseX, mouseY);
  arrPoints.add(new RPoint(mouseX, mouseY));
}

void mouseReleased()
{
  if (arrPoints.size() > 0)
  {
    SimulatedAnnealing<LineSolution> solver = new SimulatedAnnealing<LineSolution>();
    LineProblem problem = new LineProblem();
    problem.arrTargetPoints = arrPoints; 
  
    solver.init(problem);
  
    for (int n = 200000; n > 0; --n)
    {
      solver.setTemperature(n);
      solver.step();
    }
  
    stroke(0);
    strokeWeight(1);
    
    solver.m_best.m_cmd.draw();
    
    arrPoints.clear();
  }
}



