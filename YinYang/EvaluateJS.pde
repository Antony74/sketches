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

// One little wrinkle is that you have to uncomment this eval function in Java mode only.
// If you build Processing from source then it can be patched to prevent the need for this.
// https://github.com/Antony74/Processing/commit/047772019342a879810718feda579c89634a60b8

//String eval(String sCode) {return "";}

Object context;
Object scope;

boolean getIsJava()
{
  // Exploit type coercion to tell the two platforms apart
  boolean runningInJavaScript = (""+2.0==""+2);
  return !runningInJavaScript;
}

void initJS()
{
  if (getIsJava())
  {
    Context cx = Context.enter();
    
    // Rhino's default mode of operation is to compile JavaScript into JVM-byte-code and run it.
    // Remove these optimizations and make it run in interpreted mode instead.
    // There are two reasons for doing this.
    // 1. You can't put self-modifying byte-code in a Java applet... I can see why that might be a security concern ;-)
    // 2. Once we're up and running we feed Rhino a lot of throw away stuff to evaluate, so we actually get better
   //     performance by not bothering to compile everything first.
    cx.setOptimizationLevel(-1);
    
    context = cx;
    scope = cx.initStandardObjects();
  }
}

void importJS(String sFilename)
{
  if (getIsJava())
  {
    String sCode = getFileAsString(sFilename);
    evaluateJS(sCode);
  }
}

String evaluateJS(String sCode)
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


