
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;
import processing.core.*;

class LugPoints implements PConstants
{
  public LugPoints(PApplet applet)
  {
    m_applet = applet;
    style.rectMode = RADIUS;
    style.colorMode = RGB;
    style.fill = true;
    style.fillColor = applet.color(255,0,0,128);
    style.textMode = MODEL;
  }
  
  public void load()
  {
  }
  
  public void save()
  {
  }
  
  public PVector getNamed(String sName, float xDefault, float yDefault)
  {
    PointsList pointsList = m_map.get(sName);
    
    if (pointsList == null)
    {
      if (allowAdd == false)
      {
        throw new RuntimeException("allowAdd is switched off and PVector was not found");
      }
      
      pointsList = new PointsList(sName);
      
      Lug lug = new Lug(xDefault, yDefault);
      
      pointsList.arrayList.add(lug);
      m_map.put(sName, pointsList);
      return lug.pv;
    }

    PVector pv = pointsList.arrayList.get(0).pv;

    if (requireDefaults == true)
    {
      if (pv.x != xDefault || pv.y != yDefault)
      {
        throw new RuntimeException("Expected x=" + pv.x + ", y=" + pv.y);
      }
    }
    
    return pv;
  }
  
//  public PVector getNext(float xDefault, float yDefault)
//  {
//  }

  public void activate(String sName, boolean bActivate)
  {
    PointsList pointsList = m_map.get(sName);
    
    if (pointsList == null)
    {
      throw new RuntimeException(sName + " not found");
    }
    
    pointsList.active = bActivate;
  }
  
  public void draw()
  {
    m_applet.pushStyle();
    m_applet.style(style);
    
    Iterator<Map.Entry<String, PointsList> > itr = m_map.entrySet().iterator();
    
    while (itr.hasNext())
    {
      PointsList pointsList = itr.next().getValue();
      
      if (pointsList.active)
      {
        for (int n = 0; n < pointsList.arrayList.size(); ++n)
        {
          PVector pv = pointsList.arrayList.get(n).pv;
          m_applet.rect(pv.x, pv.y, rect_radius, rect_radius);
        }
      }
    }
    
    m_applet.popStyle();
  }
  
  void mousePressed(float x, float y)
  {
    Iterator<Map.Entry<String, PointsList> > itr = m_map.entrySet().iterator();
    
    while (itr.hasNext())
    {
      PointsList pointsList = itr.next().getValue();
      
      if (pointsList.active)
      {
        for (int n = 0; n < pointsList.arrayList.size(); ++n)
        {
          PVector pv = pointsList.arrayList.get(n).pv;
          if ( (Math.abs(pv.x - x) <= rect_radius)
          &&   (Math.abs(pv.y - y) <= rect_radius) )
          {
            currentName = pointsList.name;
            currentIndex = n;
            return;
          }
        }
      }
    }
    
    currentName = "";
    currentIndex = 0;
  }
  
  void mouseDragged(float x, float y)
  {
    PointsList pointsList = m_map.get(currentName);
    
    if (pointsList != null)
    {
      Lug lug = pointsList.arrayList.get(currentIndex);

      if (lug.pvMin != null && x < lug.pvMin.x)
        lug.pv.x = lug.pvMin.x;
      else if (lug.pvMax != null && x > lug.pvMax.x)
        lug.pv.x = lug.pvMax.x;
      else
        lug.pv.x = x;

      if (lug.pvMin != null && y < lug.pvMin.y)
        lug.pv.y = lug.pvMin.y;
      else if (lug.pvMax != null && y > lug.pvMax.y)
        lug.pv.y = lug.pvMax.y;
      else
        lug.pv.y = y;
    }
  }
  
  class Lug
  {
    Lug(float x, float y)
    {
      pv = new PVector(x,y);
    }
    
    PVector pv;
    
    // Optionally define a bounding box to limit where the point can be dragged
    PVector pvMin;
    PVector pvMax;
  };
  
  class PointsList
  {
    PointsList(String sName)
    {
      name = sName;
    }
    
    String name;
    boolean active = false;
    ArrayList<Lug> arrayList = new ArrayList<Lug>();
  };
  
  Map<String, PointsList> m_map = new TreeMap<String, PointsList >();
  
  public boolean allowAdd = true;
  public boolean requireDefaults = false;

  public PStyle style = new PStyle();

  final float rect_radius = 10;
  PApplet m_applet;
  
  String currentName;
  int currentIndex;
};


