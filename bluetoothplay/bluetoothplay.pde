// Requires the bluecove library.  At the time of writing there isn't a released x64 version, so I downloaded the latest snapshot from
// http://snapshot.bluecove.org/distribution/download/2.1.1-SNAPSHOT/
// I couldn't get the usual trick for deploying Java libararies as Processing libraries to work, so I just looked for Processing's core.jar
// and copied it into the directory where I found it (C:\processing-2.2.1\core\library).  Obviously that's one directory you can guarantee
// will end up on the Java CLASS_PATH ;-)
import javax.bluetooth.*;

void setup()
{
  try
  {
    LocalDevice device = LocalDevice.getLocalDevice();
  }
  catch(BluetoothStateException e)
  {
    println(e.toString());
    // I'm seeing "BluetoothStack not detected" - which just means I don't have a bluetooth dongle installed on this PC yet :-)
  }
}



