
Toolbar toolbar;
Canvas canvas;

void setup()
{
  size(900,600);
  background(255);

  toolbar = new Toolbar();
  canvas = new Canvas();

  canvas.setSize(width, height - Button.height);
  canvas.setup();
  
  Vector<Button> vecButtons = new Vector<Button>();
  
  PImage imgA = canvas.setupEffectA();
  PImage imgB = canvas.setupEffectB();
  PImage imgC = canvas.setupEffectC();
  PImage imgD = canvas.setupEffectD();
  PImage imgE = canvas.setupEffectE();
  PImage imgF = canvas.setupEffectF();
  PImage imgG = canvas.setupEffectG();
  PImage imgH = canvas.setupEffectH();
  PImage imgI = canvas.setupEffectI();
  PImage imgJ = canvas.setupEffectJ();
  
  if (imgA != null) vecButtons.add(new Button('A', imgA));
  if (imgB != null) vecButtons.add(new Button('B', imgB));
  if (imgC != null) vecButtons.add(new Button('C', imgC));
  if (imgD != null) vecButtons.add(new Button('D', imgD));
  if (imgE != null) vecButtons.add(new Button('E', imgE));
  if (imgF != null) vecButtons.add(new Button('F', imgF));
  if (imgG != null) vecButtons.add(new Button('G', imgG));
  if (imgH != null) vecButtons.add(new Button('H', imgH));
  if (imgI != null) vecButtons.add(new Button('I', imgI));
  if (imgJ != null) vecButtons.add(new Button('J', imgJ));
  
  vecButtons.add(new ZoomButton('+', 2,   canvas));
  vecButtons.add(new ZoomButton('-', 0.5, canvas));
  
  vecButtons.add(new PanButton('P',  canvas));
  
  vecButtons.add(new UndoButton('Z', canvas));
  vecButtons.add(new RedoButton('Y', canvas));

  toolbar.setButtons(vecButtons);
  
  currentTool = vecButtons.elementAt(0).cKey;

  setupWheelMouse();
  setupZoomCursors(toolbar.font);  
}

void draw()
{
  background(128);
  
  canvas.doDraw(mouseX, mouseY - Button.height, mousePressed);
  noSmooth();
  image(canvas, canvas.pannedX, canvas.pannedY + Button.height, canvas.zoomedWidth, canvas.zoomedHeight);
  drawGrid(canvas, Button.height);
  
  toolbar.draw();
  
  drawloopComplete();
}

void keyTyped()
{
  toolbar.buttonPressed(key);
  loop(1);
}

void keyPressed()
{
  loop(1);
}

void keyReleased()
{
  loop(1);
}

void mousePressed()
{
  toolbar.mousePressed();

  loop(2);
}

void mouseMoved()
{
  toolbar.mouseMoved();
}

void mouseDragged()
{
  toolbar.mouseDragged();

  loop(-1);
}

void mouseReleased()
{
  canvas.mouseReleased();

  loop(2);
}

void mouseWheel(int delta)
{
  if (delta > 0)
  {
    canvas.zoom(mouseX, mouseY - Button.height, sqrt(0.5));
  }
  else if (delta < 0)
  {
    canvas.zoom(mouseX, mouseY - Button.height, sqrt(2.0));
  }

  loop(2);
}


