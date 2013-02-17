//
// blendMorph.pde, Antony Bartlett, 2012-03-24
//
// This source-code module written in the Processing programming language is for blend-morphing
// SVG (Scalable Vector Graphics) drawings together.
//
// Blend-morphing is a technique used in 2D animation.  It requires two or more drawings that share
// the same structure, differing by coordinate value only. The purpose is to create smooth transitions
// between those drawings.
//

// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

//
// There are many programs which can be used to create and edit SVG.  Processing (with the Geomerative library) is of course one.
// Inkscape is a more conventional drawing tool, which is free and open source.
// http://www.inkscape.org/
// I'm not recommending any particular tool but I have briefly checked that Inkscape apparently preserves the structure
// of an SVG file for as long as you confine yourself to just moving stuff around.
//
// I would urge caution and baby-steps when creating SVG drawings for doing blend-morphs with.
//

// Blend-morph one SVG file into the base SVG file and draw
void blendMorph(float x, float y, String baseSVG, String morph1SVG, float morph1Proportion)
{
  Pair pair = getOrLoadShapePair(baseSVG);
  blendMorph(pair.first, getOrLoadShape(morph1SVG), morph1Proportion, pair.second);

  pushMatrix();
  translate(x,y);
  pair.second.draw();
  popMatrix();  
}

// Blend-morph two SVG files into the base SVG file and draw
void blendMorph(float x, float y, String baseSVG, String morph1SVG, float morph1Proportion, String morph2SVG, float morph2Proportion)
{
  Pair pair = getOrLoadShapePair(baseSVG);
  blendMorph(pair.first, getOrLoadShape(morph1SVG), morph1Proportion, getOrLoadShape(morph2SVG), morph2Proportion, pair.second);

  pushMatrix();
  translate(x,y);
  pair.second.draw();
  popMatrix();  
}

// Blend-morph three SVG files into the base SVG file and draw
void blendMorph(float x, float y, String baseSVG,
                String morph1SVG, float morph1Proportion,
                String morph2SVG, float morph2Proportion,
                String morph3SVG, float morph3Proportion)
{
  Pair pair = getOrLoadShapePair(baseSVG);
  blendMorph(
            pair.first,
            getOrLoadShape(morph1SVG), morph1Proportion,
            getOrLoadShape(morph2SVG), morph2Proportion,
            getOrLoadShape(morph3SVG), morph3Proportion,
            pair.second);

  pushMatrix();
  translate(x,y);
  pair.second.draw();
  popMatrix();  
}

// Blend-morph four SVG files into the base SVG file and draw
void blendMorph(float x, float y, String baseSVG,
                String morph1SVG, float morph1Proportion,
                String morph2SVG, float morph2Proportion,
                String morph3SVG, float morph3Proportion,
                String morph4SVG, float morph4Proportion)
{
  Pair pair = getOrLoadShapePair(baseSVG);
  blendMorph(
            pair.first,
            getOrLoadShape(morph1SVG), morph1Proportion,
            getOrLoadShape(morph2SVG), morph2Proportion,
            getOrLoadShape(morph3SVG), morph3Proportion,
            getOrLoadShape(morph4SVG), morph4Proportion,
            pair.second);

  pushMatrix();
  translate(x,y);
  pair.second.draw();
  popMatrix();  
}

// Blend-morph any number of SVG files into the base SVG file and draw
void blendMorph(float x, float y, String baseSVG, String arrMorphSVG[], float arrMorphProportion[])
{
  RShape base = getOrLoadShape(baseSVG);
  
  RShape arrShape[] = new RShape[arrMorphSVG.length];

  for (int n = 0; n < arrMorphSVG.length; ++n)
  {
    arrShape[n] = getOrLoadShape(arrMorphSVG[n]);
  }

  RShape shape = new RShape(base);
  blendMorph(base, arrShape, arrMorphProportion, shape);

  pushMatrix();
  translate(x,y);
  shape.draw();
  popMatrix();  
}

// Blend-morph one shape into the base shape
void blendMorph(RShape base, RShape morph, float morphProportion, RShape blend)
{
  RShape arrMorph[] = new RShape[1];
  arrMorph[0] = morph;

  float arrMorphProportion[] = new float[1];
  arrMorphProportion[0] = morphProportion;

  blendMorph(base, arrMorph, arrMorphProportion, blend);
}

// Blend-morph two shapes into the base shape
void blendMorph(RShape base, RShape morph1, float morph1Proportion, RShape morph2, float morph2Proportion, RShape blend)
{
  RShape arrMorph[] = new RShape[2];
  arrMorph[0] = morph1;
  arrMorph[1] = morph2;

  float arrMorphProportion[] = new float[2];
  arrMorphProportion[0] = morph1Proportion;
  arrMorphProportion[1] = morph2Proportion;

  blendMorph(base, arrMorph, arrMorphProportion, blend);
}

// Blend-morph three shapes into the base shape
void blendMorph(RShape base,
                  RShape morph1, float morph1Proportion,
                  RShape morph2, float morph2Proportion,
                  RShape morph3, float morph3Proportion,
                  RShape blend)
{
  RShape arrMorph[] = new RShape[3];
  arrMorph[0] = morph1;
  arrMorph[1] = morph2;
  arrMorph[2] = morph3;

  float arrMorphProportion[] = new float[3];
  arrMorphProportion[0] = morph1Proportion;
  arrMorphProportion[1] = morph2Proportion;
  arrMorphProportion[2] = morph3Proportion;

  blendMorph(base, arrMorph, arrMorphProportion, blend);
}

// Blend-morph four shapes into the base shape
void blendMorph(RShape base,
                  RShape morph1, float morph1Proportion,
                  RShape morph2, float morph2Proportion,
                  RShape morph3, float morph3Proportion,
                  RShape morph4, float morph4Proportion,
                  RShape blend)
{
  RShape arrMorph[] = new RShape[4];
  arrMorph[0] = morph1;
  arrMorph[1] = morph2;
  arrMorph[2] = morph3;
  arrMorph[3] = morph4;

  float arrMorphProportion[] = new float[4];
  arrMorphProportion[0] = morph1Proportion;
  arrMorphProportion[1] = morph2Proportion;
  arrMorphProportion[2] = morph3Proportion;
  arrMorphProportion[3] = morph4Proportion;

  blendMorph(base, arrMorph, arrMorphProportion, blend);
}

// Define a class to represent a pair of shapes.
class Pair
{
  Pair(RShape a, RShape b) {first = a; second = b;}

  // We use this to store the base drawing.
  RShape first;  

  // We use this to store the blended drawing.  Because the struture doesn't change, hanging
  // on to this is likely to be more efficent than making a copy of the base drawing every time.
  RShape second; 
};

// Define some containers to store our loaded SVG in, as it would be bad if we had to re-load it every frame!
Map<String, RShape> g_mapLoadedSVG = new TreeMap<String, RShape>();
Map<String, Pair> g_mapLoadedPairs = new TreeMap<String, Pair>();

// Get our SVG file as a Geomerative RShape, loading it in if we have not already done so.
RShape getOrLoadShape(String filename)
{
  RShape shape = g_mapLoadedSVG.get(filename);
  if (shape == null)
  {
    if (RG.initialized() == false)
    {
      RG.init(this);
    }
   
    RSVG svg = new RSVGIgnoreTagWarnings();
    shape = svg.toShape(filename);
    g_mapLoadedSVG.put(filename, shape);
  }

  return shape;
}

// Same as getOrLoadShape, except we want two copies.  The first to base our blends on, and the second to store the result.
Pair getOrLoadShapePair(String filename)
{
  Pair pair = g_mapLoadedPairs.get(filename);
  if (pair == null)
  {
    RShape shape = getOrLoadShape(filename);
    if (shape != null)
    {
      pair = new Pair(shape, new RShape(shape));
      g_mapLoadedPairs.put(filename, pair);
    }
  }
  return pair;
}

// Blend-morph any number of shapes into the base shape
void blendMorph(RShape base, RShape arrMorph[], float arrMorphProportion[], RShape blend)
{
  if (base.paths != null)
  {
    for (int n = 0; n < arrMorph.length; ++n)
    {
      if (base.paths.length != arrMorph[n].paths.length)
      {
        throw new RuntimeException("Base RShape has a different number of paths (" + base.paths.length +
                                   ") from RShape in arrMorph[" + n + "] (" + arrMorph[n].paths.length + ")");
      }
    }

    for (int nPath = 0; nPath < base.paths.length; ++nPath)
    {
      RPath arrPaths[] = new RPath[arrMorph.length];
      for (int n = 0; n < arrMorph.length; ++n)
      {
        arrPaths[n] = arrMorph[n].paths[nPath];
      }
      blendMorph(base.paths[nPath], arrPaths, arrMorphProportion, blend.paths[nPath]);
    }
  }
 
  if (base.children != null)
  {  
    for (int n = 0; n < arrMorph.length; ++n)
    {
      if (base.children.length != arrMorph[n].children.length)
      {
        throw new RuntimeException("Base RShape has a different number of children (" + base.children.length +
                                   ") from RShape in arrMorph[" + n + "] (" + arrMorph[n].children.length + ")");
      }
    }

    for (int nChild = 0; nChild < base.children.length; ++nChild)
    {
      RShape arrChildren[] = new RShape[arrMorph.length];
      for (int n = 0; n < arrMorph.length; ++n)
      {
        arrChildren[n] = arrMorph[n].children[nChild];
      }
      blendMorph(base.children[nChild], arrChildren, arrMorphProportion, blend.children[nChild]); // Recursion
    }
  }
}

// Blend-morph any number of paths into the base path
void blendMorph(RPath base, RPath arrMorph[], float arrMorphProportion[], RPath blend)
{
  for (int n = 0; n < arrMorph.length; ++n)
  {
    if (base.commands.length != arrMorph[n].commands.length)
    {
      throw new RuntimeException("Base RPath has a different number of commands (" + base.commands.length +
                                 ") from RPath in arrMorph[" + n + "] (" + arrMorph[n].commands.length + ")");
    }
  }
  
  for (int nCmd = 0; nCmd < base.commands.length; ++nCmd)
  {
    RCommand arrCmd[] = new RCommand[arrMorph.length];
    for (int n = 0; n < arrMorph.length; ++n)
    {
      arrCmd[n] = arrMorph[n].commands[nCmd];
    }
    blendMorph(base.commands[nCmd], arrCmd, arrMorphProportion, blend.commands[nCmd]);
  }
}

// Blend-morph any number of commands into the base command
void blendMorph(RCommand base, RCommand arrMorph[], float arrMorphProportion[], RCommand blend)
{
  RPoint arrStart[] = new RPoint[arrMorph.length];
  RPoint arrEnd[] = new RPoint[arrMorph.length];

  for (int n = 0; n < arrMorph.length; ++n)
  {
    if (base.controlPoints.length != arrMorph[n].controlPoints.length)
    {
      throw new RuntimeException("Base RCommand has a different number of controlPoints (" + base.controlPoints.length +
                                 ") from RCommand in arrMorph[" + n + "] (" + arrMorph[n].controlPoints.length + ")");
    }

    arrStart[n] = arrMorph[n].startPoint;
    arrEnd[n] = arrMorph[n].endPoint;
  }

  blendMorph(base.startPoint, arrStart, arrMorphProportion, blend.startPoint);
  blendMorph(base.endPoint, arrEnd, arrMorphProportion, blend.endPoint);

  if (base.controlPoints != null)
  {
    for (int nPt = 0; nPt < base.controlPoints.length; ++nPt)
    {
      RPoint arr[] = new RPoint[arrMorph.length];
      
      for (int n = 0; n < arrMorph.length; ++n)
      {
        arr[n] = arrMorph[n].controlPoints[nPt];
      }
      
      blendMorph(base.controlPoints[nPt], arr, arrMorphProportion, blend.controlPoints[nPt]);
    }
  }
}

// Blend-morph any number of points into the base point
void blendMorph(RPoint base, RPoint arrMorph[], float arrMorphProportion[], RPoint blend)
{
  float arrX[] = new float[arrMorph.length];
  float arrY[] = new float[arrMorph.length];

  for (int n = 0; n < arrMorph.length; ++n)
  {
    arrX[n] = arrMorph[n].x;
    arrY[n] = arrMorph[n].y;
  }

  blend.x = blendMorph(base.x, arrX, arrMorphProportion);
  blend.y = blendMorph(base.y, arrY, arrMorphProportion);
}

//
// Blend-morph any number of individual coordinates into the base coordinate
//
// Here we see that at it's heart a blend-morpth is a really simple operation - completely linear actually.
// It's just all the (above) iterating through multiple shapes, paths, commands and points, required before we
// could get to here that makes it seem... not exactly difficult, but certainly somewhat heavy-going.
//
float blendMorph(float base, float arrMorph[], float arrMorphProportion[])
{
  if (arrMorph.length != arrMorphProportion.length)
  {
    throw new RuntimeException("Length of arrMorph (" + arrMorph.length + ") does not match length of arrMorphProportion (" + arrMorphProportion.length + ")");
  }
  
  float blend = base;
  
  for (int n = 0; n < arrMorph.length; ++n)
  {
    float distance = (arrMorph[n] - base) * arrMorphProportion[n];
    blend += distance;
  }

  return blend;
}

//
// Suppress the warning messages that certain Inkscape tags create.
// This is a horrible hack but those messages are just going to cause clutter and confusion!
//
class RSVGIgnoreTagWarnings extends RSVG
{
  public RShape elemToCompositeShape(XMLElement elem)
  {
    XMLElement elems[] = elem.getChildren();
    for (int i = 0; i < elems.length; i++)
    {
      String name = elems[i].getName().toLowerCase();
      XMLElement element = elems[i];

      if (name.equals("metadata")
      ||  name.equals("sodipodi:namedview"))
      {
        elem.removeChild(element);
      }
    }

    return super.elemToCompositeShape(elem);
  }
}

