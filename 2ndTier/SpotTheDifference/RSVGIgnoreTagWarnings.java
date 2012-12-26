// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

// Also makes use of Processing's XML parser
import processing.xml.XMLElement;

//
// Suppress the warning messages related to tags Inkscape uses.
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


