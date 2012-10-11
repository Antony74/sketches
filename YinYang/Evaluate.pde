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
    Object o = cx.evaluateString((Scriptable)scope, sCode, "<cmd>", 1, null);
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
    return new Scanner( new File(sFilename) ).useDelimiter("\\A").next();
  }
  catch(IOException e)
  {
    return "";
  }
}


