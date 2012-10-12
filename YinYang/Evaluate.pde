//
// Evaluate.pde
//
// Evaluation of JavaScript cross-compatible with two Processing platforms.
// 1. Standard Java-based Processing (using the JavaScript engine provided by Rhino).
// 2. Processing.js (evaluating JavaScript natively).
//

// Import Rhino - a Java-based implementation of JavaScript
// http://www.mozilla.org/rhino/
import org.mozilla.javascript.*;

// One little wrinkle is that you may have to uncomment this in Java mode only.
//String eval(String sCode) {return null;}

Object context;
Object scope;

boolean getIsJava()
{
  // Exploit type coercion to tell the two platforms apart
  boolean runningInJavaScript = (""+2.0==""+2);
  return !runningInJavaScript;
}

String evaluate(String sCode)
{
  if (getIsJava())
  {
    Context cx = (Context)context;
    Object o;

    try
    {
      o = cx.evaluateString((Scriptable)scope, sCode, "<cmd>", 1, null);
    }
    catch(RuntimeException e)
    {
      text(e.toString(),100,100);
      noLoop();
      return "";
    }
    
    return o.toString();
  }
  else
  {
    return eval(sCode);
  }
}

String getFileAsString(String sFilename)
{
  try
  {
    InputStream stream;
    try
    {
      getAppletContext();
      stream = createInput(sFilename);    
    }
    catch(NullPointerException e)
    {
      stream = new FileInputStream(savePath(sFilename));
    }
    
    String s = new Scanner( stream ).useDelimiter("\\A").next();

    return s;
  }
  catch(IOException e)
  {
    return "";
  }
}


