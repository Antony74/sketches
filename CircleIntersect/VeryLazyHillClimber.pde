
interface PVectorInterface<VECSUBCLASS>
{
  PVectorInterface get();
  void set(VECSUBCLASS other);
  float mag();
  int directions();
  void move(int nDirection);
};

class PVector2D extends PVector implements PVectorInterface<PVector2D>
{
  PVector2D(float x, float y, float xIncrement, float yIncrement)
  {
    super(x,y);
    this.xIncrement = xIncrement;
    this.yIncrement = yIncrement;
  }
  
  void set(PVector2D other)
  {
    super.set(other);
    this.xIncrement = other.xIncrement;
    this.yIncrement = other.yIncrement;
  }
  
  PVector2D get()
  {
    return new PVector2D(x, y, xIncrement, yIncrement);
  }

  int directions() {return 4;}

  void move(int nDirection)
  {
    switch(nDirection)
    {
    case 0:
      x -= xIncrement;
      break;
    case 1:
      x += xIncrement;
      break;
    case 2:
      y -= yIncrement;
      break;
    case 3:
      y += yIncrement;
      break;
    default:
      throw new RuntimeException("Direction out of range");
    }
  }
  
  float xIncrement;
  float yIncrement;
};

interface FitnessEvaluator<VECSUBCLASS>
{
  float evaluate(VECSUBCLASS pvi);
};

PVectorInterface veryLazyHillClimber(PVectorInterface pvStart, FitnessEvaluator fitnessEvaluator)
{
  PVectorInterface pvBest = pvStart.get();

  float best = fitnessEvaluator.evaluate(pvBest);

  PVectorInterface pvCurrent = pvBest.get();

  for (;;)
  {
    float prevBest = best;

    for(int n = 0; n < pvBest.directions(); ++n)
    {
      pvCurrent.set(pvBest);
      pvCurrent.move(n);
      float current = fitnessEvaluator.evaluate(pvCurrent);
      
      if (current < best)
      {
        pvBest.set(pvCurrent);
        best = current;
        continue;
      }
    }

    if (prevBest == best)
      break;
  }

  return pvBest;
}


