
// This is the command line I use for running the Spiro sketch on it's own, just to prove it works.
//
// java -cp Spiro.jar;core.jar Spiro

// This is the command line I use to compile this source file.
//
// javac -classpath .;../../../Processing/processing/build/windows/work/core/library/core.jar SubSketchInsert.java

// This is the command line I use to run this code and get it to insert itself into the Spiro sketch.
//
// java -classpath .;../../../Processing/processing/build/windows/work/core/library/core.jar SubSketchInsert Spiro ../../Spiro/application.linux32/lib/Spiro.jar


import java.io.InputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.util.jar.JarFile;
import java.util.zip.ZipEntry;

public class SubSketchInsert extends processing.core.PGraphics
{
	UUEncoder m_UUEncoder;
	boolean m_bSizeSet = false;
	processing.core.PApplet m_subsketch;
	String m_sSketchClassname;
	String m_sJarFilename;

	public static void main(String[] args)
	{
		if (args.length == 2)
		{
			SubSketchInsert sub = new SubSketchInsert();
			sub.m_sSketchClassname = args[0];
			sub.m_sJarFilename = args[1];
			sub.doMain();
		}
		else
		{
			System.err.println();
			System.err.println("Usage: sketchClassname jarFilename");
		}
	}

	void doMain()
	{
		m_UUEncoder = new UUEncoder(System.out);
		System.setOut(System.err); // Keep the output stream for communicating about this sub-sketch
	
		ClassLoader myClassLoader = new ClassLoaderInsert(Thread.currentThread().getContextClassLoader());

		try
		{
			Class<?> classSubSketch = myClassLoader.loadClass(m_sSketchClassname);

			m_subsketch = (processing.core.PApplet)classSubSketch.newInstance();

			m_subsketch.beginRecord(this);
			m_subsketch.runSketch(new String[]{m_subsketch.getClass().getName()}, m_subsketch);
		}
		catch (Exception e)
		{
			System.err.println(e.toString());
		}
	}

	public void pushMatrix() {}
	public void resetMatrix() {}
	public void popMatrix() {}

	public void endDraw()
	{
		if (m_bSizeSet == false)
		{
			m_UUEncoder.print(m_subsketch.width);
			m_UUEncoder.print(m_subsketch.height);
			m_bSizeSet = true;
		}
		
		m_subsketch.loadPixels();
		for (int n = 0; n < m_subsketch.pixels.length; ++n)
		{
			m_UUEncoder.print(m_subsketch.pixels[n]);
		}
	}

	//
	// UUEncoder
	//
	class UUEncoder
	{
		byte m_buffer[];
		int m_nSize;
		int m_nColumn;
		PrintStream m_PrintStream;
		
		UUEncoder(PrintStream ps)
		{
			m_buffer = new byte[3];
			m_nSize = 0;
			m_nColumn = 0;
			m_PrintStream = ps;
		}
		
		void print(int n)
		{
			m_buffer[m_nSize] = (byte)(n >>> 0);
			++m_nSize;
			if (m_nSize == 3) print2();
			m_buffer[m_nSize] = (byte)(n >>> 8);
			++m_nSize;
			if (m_nSize == 3) print2();
			m_buffer[m_nSize] = (byte)(n >>> 16);
			++m_nSize;
			if (m_nSize == 3) print2();
			m_buffer[m_nSize] = (byte)(n >>> 24);
			++m_nSize;
			if (m_nSize == 3) print2();
		}
		
		void print2()
		{
			byte b1 = (byte)( 32 + (m_buffer[0] >>> 2) );
			
			int n2a = (m_buffer[0] & 0x3) << 4;
			int n2b = m_buffer[1] >>> 4;
			
			byte b2 = (byte)( 32 + (n2a | n2b) );

			int n3a = (m_buffer[1] & 0xF) << 2;
			int n3b = m_buffer[2] >>> 6;
			
			byte b3 = (byte)(32 + (n3a | n3b) );
			
			byte b4 = (byte)( 32 + (m_buffer[2] & 0x3F) );

			m_PrintStream.print((char)b1);
			m_PrintStream.print((char)b2);
			m_PrintStream.print((char)b3);
			m_PrintStream.print((char)b4);

			m_nSize = 0;
			m_nColumn += 4;

			if (m_nColumn == 60)
			{
				m_PrintStream.println();
				m_nColumn = 0;
			}

		}
		
	};

	//
	// ClassLoaderInsert
	//
	class ClassLoaderInsert extends ClassLoader
	{
		protected ClassLoaderInsert(ClassLoader parent)
		{
			super(parent);
			
			try
			{
				sketch = new JarFile(m_sJarFilename);
			}
			catch(IOException e)
			{
				System.err.println(e.toString());
			}
		}
	
		public Class findClass(String className) throws ClassNotFoundException
		{
//			System.out.println(className);
			
			String filename = className + ".class";
			
			ZipEntry entry = sketch.getEntry(filename);
			
			InputStream inputStream = null;
				
			if (entry != null)
			{
//				System.out.println("found");
				
				try
				{
					inputStream = sketch.getInputStream(entry);
				}
				catch(IOException e)
				{
					System.err.println(e.toString());
				}
			}

			if (inputStream != null)
			{
				try
				{
					int len = inputStream.available();
					byte buffer[] = new byte[len];
					inputStream.read(buffer, 0, len);
					
					return defineClass(className, buffer, 0, len);
				}
				catch(IOException e)
				{
					System.err.println(e.toString());
				}
			}
			
			return super.findClass(className);
		}
		
		JarFile sketch;
	};
};

