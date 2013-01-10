
import java.io.IOException;
import java.io.InputStreamReader;

class SubSketch extends PGraphicsJava2D
{
  Process m_process;
  UUDecoder m_UUDecoder;
  boolean m_bSizeSet = false;
  
  SubSketch(String sSketchName, String sSketchJar)
  {
    try
    {
      String sClassPath = sketchPath("SubSketchInsert") + ";" + sketchPath("SubSketchInsert/core.jar");
      
      ProcessBuilder pb = new ProcessBuilder("java", "-cp", sClassPath, "SubSketchInsert", sSketchName, sSketchJar);
      
      printCommand(pb);
      
      m_process = pb.start();
    
      m_UUDecoder = new UUDecoder(m_process.getInputStream());
 
    }
    catch (IOException e)
    {
      println(e.toString());
    }
  }

  void printCommand(ProcessBuilder pb)
  {
      Object arr[] = pb.command().toArray();
      
      for (int n = 0; n < arr.length; ++n)
      {
        print((String)arr[n]);
        print(" ");
      }
      println();
  }

  void getFrame()
  {  
    try
    {
      int nInputBytes = 0;
      
      if (m_bSizeSet == false)
      {
        while (nInputBytes < 8)
        {
          int nErrorBytes = m_process.getErrorStream().available();
     
          if (nErrorBytes > 0)
          {
            byte buffer[] = new byte[nErrorBytes];
            m_process.getErrorStream().read(buffer, 0, nErrorBytes);
            String msg = new String(buffer);
            println(msg);
          }
  
          nInputBytes = m_process.getInputStream().available();
          
          if (nInputBytes < 8)
          {
            Thread.currentThread().sleep(10);
          }
        }
        
        int nWidth = m_UUDecoder.readInt();
        int nHeight = m_UUDecoder.readInt();
        m_bSizeSet = true;
        
        println(nWidth);
        println(nHeight);
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
  
  //
  // UUDecoder
  //
  class UUDecoder
  {
    int m_buffer[];
    int m_nPosition;
    BufferedReader m_BufferedReader;
    
    UUDecoder(InputStream inputStream)
    {
      m_buffer = new int[3];
      m_nPosition = 3;
      m_BufferedReader = new BufferedReader(new InputStreamReader(inputStream));
    }
    
    int readInt() throws IOException
    {
      if (m_nPosition == 3) readThreeBytes();
      int b1 = m_buffer[m_nPosition];
      ++m_nPosition;
      if (m_nPosition == 3) readThreeBytes();
      int b2 = m_buffer[m_nPosition];
      ++m_nPosition;
      if (m_nPosition == 3) readThreeBytes();
      int b3 = m_buffer[m_nPosition];
      ++m_nPosition;
      if (m_nPosition == 3) readThreeBytes();
      int b4 = m_buffer[m_nPosition];
      ++m_nPosition;

      return (b1 << 0) | (b2 << 8);// | (b3 << 16) | (b4 << 24);
    }

    void readThreeBytes() throws IOException
    {
      int b1 = readByte();
      int b2 = readByte();
      int b3 = readByte();
      int b4 = readByte();
      
      print((char)b1);
      print((char)b2);
      print((char)b3);
      print((char)b4);
      println();
      
      b1 &= 0x7F;
      b2 &= 0x7F;
      b3 &= 0x7F;
      b4 &= 0x7F;

      b1 -=32;
      b2 -=32;
      b3 -=32;
      b4 -=32;
      
      m_buffer[0] = (b1 << 2) | (b2 >>> 4);
      m_buffer[1] = ((b2 & 0xF) << 4) | (b3 >>> 2);
      m_buffer[2] = ((b3 & 0x3) << 6) | b4;
      
      m_nPosition = 0;
    }

    int readByte() throws IOException
    {
      int n = 0;
      while (n < 32)
      {
        n = m_BufferedReader.read();
      }

      return n;
    }

  };

};


