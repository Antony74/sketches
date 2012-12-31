
// java -classpath .;../../../Processing/processing/build/windows/work/core/library/core.jar SubSketch

// java -cp Spiro.jar;core.jar Spiro

import java.io.InputStream;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.util.jar.JarFile;
import java.util.zip.ZipEntry;

class SubSketch
{
	public static void main(String[] args)
	{
		SubSketch sub = new SubSketch();
		sub.doSomething(args);
	}

	void doSomething(String[] args)
	{
		ClassLoader clParent = Thread.currentThread().getContextClassLoader();
		ClassLoader clChild = new SubSketchClassLoader(clParent);
		Thread.currentThread().setContextClassLoader(clChild);

		try
		{
			Class<?> mainClass = Thread.currentThread().getContextClassLoader().loadClass("Spiro");

			Runnable theSubSketch = (Runnable) mainClass.newInstance();

			Method method = mainClass.getDeclaredMethod("main", new Class[]{String[].class});

			System.out.println("prerun");
			method.invoke(theSubSketch, new Object[]{args});
			System.out.println("postrun");
		}
		catch (Exception e)
		{
			System.err.println(e.toString());
		}
	}

	void doSomethingElse()
	{
		UUEncoder en = new UUEncoder();
		en.print(0x00746143);
		System.out.println();
	}

	class UUEncoder
	{
		byte m_buffer[];
		int m_nSize;
		int m_nColumn;
		
		UUEncoder()
		{
			m_buffer = new byte[3];
			m_nSize = 0;
			m_nColumn = 0;
		}
		
		void print(int n)
		{
			m_buffer[m_nSize] = (byte)(n >> 0);
			++m_nSize;
			if (m_nSize == 3) print2();
			m_buffer[m_nSize] = (byte)(n >> 8);
			++m_nSize;
			if (m_nSize == 3) print2();
			m_buffer[m_nSize] = (byte)(n >> 16);
			++m_nSize;
			if (m_nSize == 3) print2();
			m_buffer[m_nSize] = (byte)(n >> 24);
			++m_nSize;
			if (m_nSize == 3) print2();
		}
		
		void print2()
		{
			byte b1 = (byte)( 32 + (m_buffer[0] >> 2) );
			
			int n2a = (m_buffer[0] & 0x3) << 4;
			int n2b = m_buffer[1] >> 4;
			
			byte b2 = (byte)( 32 + (n2a | n2b) );

			int n3a = (m_buffer[1] & 0xF) << 2;
			int n3b = m_buffer[2] >> 6;
			
			byte b3 = (byte)(32 + (n3a | n3b) );
			
			byte b4 = (byte)( 32 + (m_buffer[2] & 0x3F) );

			System.out.print((char)b1);
			System.out.print((char)b2);
			System.out.print((char)b3);
			System.out.print((char)b4);

			m_nSize = 0;
			m_nColumn += 4;

			if (m_nColumn == 80)
			{
				System.out.println();
				m_nColumn = 0;
			}

		}
		
	};

	class SubSketchClassLoader extends ClassLoader
	{
		protected SubSketchClassLoader(ClassLoader parent)
		{
			super(parent);
			
			try
			{
				sketch = new JarFile("../../Spiro/application.linux32/lib/Spiro.jar");
			}
			catch(IOException e)
			{
				System.err.println(e.toString());
			}
		}
	
		public Class findClass(String className) throws ClassNotFoundException
		{
			System.out.println(className);
			
			String filename = className + ".class";
			
			ZipEntry entry = sketch.getEntry(filename);
			
			InputStream inputStream = null;
				
			if (entry != null)
			{
				System.out.println("found");
				
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

