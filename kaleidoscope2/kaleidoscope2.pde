
// The mirror is defined by the line ax + by + c = 0
void applyMirrorEffect(color arrPixels[], int nWidth, int nHeight, float a, float b, float c, boolean bReflectPositiveToNegative)
{
  PVector pvec = new PVector();
  float fTwiceLength = sqrt((a*a) + (b*b)) * 0.5;

  for (int n = 0; n < nWidth*nHeight; ++n)
  {
    pvec.x = n % nWidth;
    pvec.y = n / nWidth;

    applyMirrorEffect(pvec, nWidth, nHeight, a, b, c, bReflectPositiveToNegative, fTwiceLength);

    int x3 = (int)pvec.x;
    int y3 = (int)pvec.y;

    if (x3 >= 0 && x3 < nWidth && y3 >= 0 && y3 < nHeight)
    {
      arrPixels[n] = arrPixels[(y3*nWidth) + x3];
    }
    else
    {
      arrPixels[n] = getBackground().getRGB();
    }
  }
}

// The mirror is defined by the line ax + by + c = 0
void applyMirrorEffect(PVector pvec, int nWidth, int nHeight, float a, float b, float c, boolean bReflectPositiveToNegative, float fTwiceLength)
{
  float fDist = perpendicularDistance(pvec.x, pvec.y, a, b, c);
  
  if (fDist < 0 ^ bReflectPositiveToNegative)
  {
    fDist = abs(fDist);
    float x2 = (-b * fDist) / fTwiceLength;
    float y2 = ( a * fDist) / fTwiceLength;
  
    pvec.x = pvec.x - (int)x2;
    pvec.y = pvec.y - (int)y2;
  }
}

// Calculate the perpendicular distance from point (x1, y1) to line y = kx + m 
float perpendicularDistance(float x1, float y1, float k, float m)
{
  float numerator = (k*x1) - y1 + m;
  float denominator = sqrt((k*k) + 1);
  return numerator/denominator;
}

// Calculate the perpendicular distance from point (x1, y1) to line ax + by + c = 0
float perpendicularDistance(float x1, float y1, float a, float b, float c)
{
  float numerator = (a*x1) + (b*y1) + c;
  float denominator = sqrt((a*a) + (b*b));
  return numerator/denominator;
}


