
import java.io.IOException;
import java.io.InputStreamReader;

void setup()
{
//  throw new RuntimeException("Bored now");

  println("Running Presentation");
  
  ProcessBuilder pb = new ProcessBuilder("java", "-cp", sketchPath("SubSketch"), "SubSketch");
  		 
  try
  {
    Process p = pb.start();

    BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
    
    while (true)
    {
      Thread.currentThread().sleep(10);
      
      int nErrorBytes = p.getErrorStream().available();
 
      if (nErrorBytes > 0)
      {
        byte buffer[] = new byte[nErrorBytes];
        p.getErrorStream().read(buffer, 0, nErrorBytes);
        String msg = new String(buffer);
        println(msg);
      }

      int nInputBytes = p.getInputStream().available();
      if (nInputBytes > 0)
      {
        println(br.readLine());
      }
    }
  }
  catch (IOException e)
  {
    println(e.toString());
  }
  catch (InterruptedException e)
  {
    println(e.toString());
  }
}


