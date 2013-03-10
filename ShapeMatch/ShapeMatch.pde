
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
}

void draw()
{
}

void mouseDragged()
{
  stroke(0, 0, 255);
  strokeWeight(2);
  line(pmouseX, pmouseY, mouseX, mouseY);
  arrPoints.add(new RPoint(mouseX, mouseY));
}

void mouseReleased()
{
  if (arrPoints.size() > 0)
  {
    int nSteps = 100000;
//    SimulatedAnnealing<LineSolution> solver = new SimulatedAnnealing<LineSolution>(nSteps);
//    LineProblem problem = new LineProblem();

    SimulatedAnnealing<HeartSolution> solver = new SimulatedAnnealing<HeartSolution>(nSteps);
    Problem problem = new HeartProblem();
    
    problem.setTargetPoints(arrPoints); 
  
    solver.init(problem);
  
    for (int n = 0; n < nSteps; ++n)
    {
      solver.step();
    }
  
    stroke(255, 0, 0, 128);
    fill(128, 0, 0, 128);
    strokeWeight(5);
    
    problem.draw(solver.m_best);
    
    arrPoints.clear();
  }
}



