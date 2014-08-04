
int nCount = 0;
PFont font;
int nFontSize;

void setup()
{
  size(1200, 800);  

  nFontSize = (int)(height*0.75);
  font = createFont("Arial", nFontSize);
}

void draw()
{
  background(255);
  fill(0);
  textFont(font);
  translate(width/2, height/2);
  String sCount;
  switch(nCount)
  {
  default:
  case 0:  sCount = "0";  break;
  case 1:  sCount = "1";  break;
  case 2:  sCount = "2";  break;
  case 3:  sCount = "3";  break;
  case 4:  sCount = "4";  break;
  case 5:  sCount = "5";  break;
  case 6:  sCount = "6";  break;
  case 7:  sCount = "7";  break;
  case 8:  sCount = "8";  break;
  case 9:  sCount = "9";  break;
  case 10: sCount = "10"; break;
  }

  text(sCount, -(textWidth(sCount)/2), (nFontSize/3));
  noLoop();
}

void keyPressed()
{
  if (key == 'r' || nCount > 9)
  {
    nCount = 0;
  }
  else
  {
    ++nCount;
  }

  loop();
}


