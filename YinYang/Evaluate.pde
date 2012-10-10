
// Import Rhino - a Java-based implementation of JavaScript
// http://www.mozilla.org/rhino/
import org.mozilla.javascript.*;

Object context;
Object scope;

boolean getIsJava()
{
  // Exploit type coercion to tell the two platforms apart
  boolean runningInJavaScript = (""+2.0==""+2);
  return !runningInJavaScript;
}

//Object eval(String sCode) {return null;}

Object evaluate(String sCode)
{
  if (getIsJava())
  {
    Context cx = (Context)context;
    return cx.evaluateString((Scriptable)scope, sCode, "<cmd>", 1, null);
  }
  else
  {
    return eval(sCode);
  }
}

boolean evaluateBoolean(String sCode)
{
  return (Boolean)evaluate(sCode);
}

float evaluateFloat(String sCode)
{
  // Nasty hack for compatibility with both Java and Javascript.  Note that Float is defined in YinYang.js.
  String s = evaluate(sCode).toString();
  return Float.parseFloat(s);
}

String getFileAsString(String sFilename)
{
  try
  {
    return new Scanner( new File(sFilename) ).useDelimiter("\\A").next();
  }
  catch(IOException e)
  {
    return "";
  }
}


