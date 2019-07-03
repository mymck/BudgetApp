<%@page import="java.util.*,java.time.*,Budget.Filing"%>
<%@ include file="include.jsp"%>
<%
	String user = request.getParameter("user");
	//is there a user that we can examine?
	if (user != null && (user.compareTo("") != -1)) {
		
		String data = Filing.readFrom(pathRoot+user+fileType);
		
		//monday,friday,c20,c10,[c20],[c10] file layout, monday and friday are longs (seconds) that correspond to the current week
		//c20/c10 values are integers and set the length of the arrays at the end of the file
		
		//testing on basic seperator (" ") did not split properly
		String[] spl = data.replace(seperator, " ").split(" ");
		String err = "";
		try {
			long monday = Long.parseLong(spl[0]);
			long friday = Long.parseLong(spl[1]);
			long current = Instant.now().getEpochSecond();
			c20 = Integer.parseInt(spl[2]);
			c10 = Integer.parseInt(spl[3]);
			//0-3 are standard
			if (request.getParameter("update") != null) {
				err = "in update";
				//see if we need to update c20(fridays) or update all (mondays)
				if (getMonday() != monday) {
					//check if new week
					spl[0] = ""+getMonday();
					spl[1] = ""+getFriday();
					for (int i=4; i < 4+c20+c10; i++) {
						spl[i] = ""+0;
					}
				} else if (friday < current) {
					//check if we're past friday
					spl[1] = ""+getSunday();
					for (int i=4; i < 4+c20; i++) {
						spl[i] = ""+0;
					}
				}
				err = "end update";
			}
			//use one charge on the c20 budget
			if (request.getParameter("c20") != null) {
				//look between 4 and c20+3
				for (int i=4; i < 4+c20; i++) {
					if (spl[i].compareTo("0") == 0) {
						spl[i] = ""+current;
						break;
					}
				}
			}
			//use one charge on the c10 budget
			if (request.getParameter("c10") != null) {
				//look between c20+4=x and x+c10
				int x = 4+c20; //end of the c20 block of charges
				for (int i=x; i < x+c10; i++) {
					if (spl[i].compareTo("0") == 0) {
						spl[i] = ""+current;
						break;
					}
				}
			}
			Filing.writeTo(pathRoot+user+fileType, String.join(seperator, spl));
		} catch (NumberFormatException nfe) {
			if (err.compareTo("") == 0) {
				err = nfe.getMessage();
			}
			out.println("Error " + err);
		} finally {
			out.print(Filing.readFrom(pathRoot+user+fileType));
		}
	}
%>