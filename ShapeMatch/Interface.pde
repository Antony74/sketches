
interface Solution
{
  public abstract int getVariableCount();
  public abstract float getVariable(int nVariable);
};

// Here's a really simply way of defining a problem - keeping everything about it in one
// place... although greater flexibility could be had by breaking this into several interfaces.
interface Problem<SOLUTION extends Solution>
{
  public abstract float getMin(int nVariable);
  public abstract float getMax(int nVariable);

  public abstract float assessFitness(SOLUTION s);
  public abstract boolean aFitterThanB(float a, float b);

  public abstract SOLUTION getRandomSolution();
  public abstract SOLUTION tweak(SOLUTION s);
};

interface Solver<SOLUTION extends Solution>
{
  public abstract void init(Problem<SOLUTION> problem);
  public abstract void step();
};


