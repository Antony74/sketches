
SubSketch mySubSketch;

void setup()
{
  size(640, 480);
  println("Running Presentation");

  mySubSketch = new SubSketch("Spiro", sketchPath("../Spiro/application.linux32/lib/Spiro.jar"));
}

void draw()
{
  mySubSketch.getFrame();
  image(mySubSketch, 0, 0);
}


