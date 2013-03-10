
interface Problem<SOLUTION>
{
  public abstract float assessFitness(SOLUTION s);
  public abstract boolean aFitterThanB(float a, float b);

  public abstract SOLUTION getRandomSolution();
  public abstract SOLUTION tweak(SOLUTION s);
  
  public abstract void setTargetPoints(ArrayList<RPoint> arr);
  public void draw(SOLUTION s);
};

interface Solver<SOLUTION>
{
  public abstract void init(Problem<SOLUTION> problem);
  public abstract void step();
};


