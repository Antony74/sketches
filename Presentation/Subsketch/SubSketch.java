
class SubSketch
{
	public static void main(String[] args)
	{
		SubSketch sub = new SubSketch();
		sub.doSomething();
	}

	void doSomething()
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

};

