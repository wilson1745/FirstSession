
<%@ page import="java.io.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<html>
<head>
<title>Reading Binary Data</title>
</head>

<body>
	<h1>Reading Binary Data</h1>
	This page reads binary data from a file.
	<br> Read this data:
	<br>
	<br>

	<%
		/*File file = new File("C:/Users/cbluo/git/FirstSession/WebContent/cookie.gif");
		byte[] binary = new byte[(int) file.length()];
		InputStream ins = this.getServletContext().getResourceAsStream(file.getName());
		ins.read(binary);
		ins.close();*/

		File rf = new File("C:\\Users\\cbluo\\Desktop\\cookie.gif");
		int size = 0;

		if (rf != null && rf.exists()) {
			try {
				InputStream is = new FileInputStream(rf);
				//byte binarys[] = new byte[1024];
				byte binarys[] = new byte[(int) rf.length()];

				int t = 0;
				while ((t = is.read(binarys)) > 0) {
					size += t;
					for (int i = 0; i < t; i++) {
						System.out.printf("%02x ", binarys[i]);
						out.println(String.format("%02x", binarys[i]));

						if ((i + 1) % 8 == 0) {
							if ((i + 1) / 8 % 2 == 0) System.out.println();
							else out.print("\t");
						}
					}
				}

				is.close();
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
		}
	%>
	<br>
	<br>
	<%
		out.println("Size = " + size + "...\n");

		/*String file = application.getRealPath("/cookie.gif");
		FileInputStream fileinputstream = new FileInputStream(file);
		
		int numberBytes = fileinputstream.available();
		byte bytearray[] = new byte[numberBytes];
		
		fileinputstream.read(bytearray);
		
		for (int i = 0; i < numberBytes; i++) {
			out.println(bytearray[i]);
		}
		
		fileinputstream.close();*/
	%>
</body>
</html>