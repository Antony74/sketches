
float m_textSize = 16;

void setup()
{
  size(640, 480);
  fill(0);
  background(255);
  textSize(m_textSize);
  
  float dataA[] = {1, 2, 3,
                   4, 5, 6};
  
  float dataB[] = {1, 2,
                   3, 4,
                   5, 6};
  
  Matrix A = new Matrix(3, 2, dataA);
  Matrix B = new Matrix(2, 3, dataB);

  Matrix C = multiply(A, B);

  translate(textWidth("     "), height/2);
  A.draw();
  B.draw();
  text(" = ", 0, -m_textSize/2);
  translate(textWidth(" = "), 0);
  C.draw();
}

Matrix multiply(Matrix A, Matrix B)
{
  if (A.m.length != B.m[0].length)
  {
    throw new RuntimeException("Not compatible");
  }

  Matrix C = new Matrix(B.m.length, A.m[0].length);
  
  for (int x = 0; x < C.m.length; ++x)
  {
    for (int y = 0; y < C.m[0].length; ++y)
    {
      float value = 0;
      
      for (int z = 0; z < A.m.length; ++z)
      {
        value += A.m[z][y] * B.m[x][z];
      }
      
      C.m[x][y] = value;
    }
  }
  
  return C;
}

class Matrix
{
  Matrix(int nWidth, int nHeight, float data[])
  {
    if (data.length != nWidth * nHeight)
    {
      throw new RuntimeException("Wrong amount of data");
    }
    
    m = new float[nWidth][nHeight];
    
    for (int x = 0; x < nWidth; ++x)
    {
      for (int y = 0; y < nHeight; ++y)
      {
        m[x][y] = data[(y * nWidth) + x];
      }
    }
  }
  
  Matrix(int nWidth, int nHeight)
  {
    m = new float[nWidth][nHeight];
  }

  String cell(int x, int y)
  {
    return str(m[x][y]);
  }

  float calculateColumnWidth()
  {
    float colWidth = 0;
    
    for (int x = 0; x < m.length; ++x)
    {
      for (int y = 0; y < m[0].length; ++y)
      {
        float colWidth2 = textWidth(cell(x,y));
        colWidth = max(colWidth, colWidth2);
      }
    }
    
    return colWidth;
  }
  
  void drawBracket(String s)
  {
    textSize(m_textSize * m[0].length);
    text(s, -textWidth(s)/2, 0);
    translate(textWidth(s), 0);
    textSize(m_textSize);
  }
  
  void draw()
  {
    translate(m_textSize, 0);

    float colWidth = calculateColumnWidth() * 1.5;
    float vCentre = (m_textSize * m[0].length * 1.5) / 2;

    drawBracket("(");
    
    for (int x = 0; x < m.length; ++x)
    {
      for (int y = 0; y < m[0].length; ++y)
      {
        text(cell(x,y), colWidth * x, (m_textSize * y * 1.5) - vCentre);
      }
    }
    
    translate(colWidth * m.length, 0);

    drawBracket(")");

    translate(m_textSize, 0);
  }
  
  float m[][];
};


