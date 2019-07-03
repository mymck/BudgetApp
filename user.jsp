<%@page import="java.util.*,java.time.*,Budget.Filing"%>
<%@include file="include.jsp"%>
<%!
//placeholder function for later when filtering characters
	String[] stringFilter(String str, String token){
		String[] result = {str};
		return result;
	}
%>
<%
//saves any new information and returns the most recent copy of the file.
	String user = request.getParameter("user");
	if (user != null && user.compareTo("") != 0) {
		//no filter on user
		user = stringFilter(user," ")[0];
		// out.print(user);
		if (!Filing.exists(pathRoot+user+fileType)) {
			try {//If there exists a user for this person retrieve their parameters.
				c20 = Integer.parseInt(request.getParameter("c20"));
				c10 = Integer.parseInt(request.getParameter("c10"));
			} catch (NumberFormatException nfe) {//block bad inputs
				c20 = 0;
				c10 = 0;
			}
			// out.print(c20 +" "+ c10);
			String[] extraFields = new String[c20+c10];
			setWrite(extraFields, ""+0);
			setWrite(toWrite, ""+getMonday(),""+getFriday(),""+c20,""+c10);
			
			String result = String.join(seperator,toWrite);
			String result2 = String.join(seperator,extraFields);
			Filing.writeTo(pathRoot+user+fileType,result+seperator+result2);
			out.print(Filing.readFrom(pathRoot+user+fileType));
			
		} else {
			out.print(Filing.readFrom(pathRoot+user+fileType));
		}
	}
%>