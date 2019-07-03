<%!

	//Uses a relative path from the root of the web server
	String pathRoot ="./tomcat/webapps/ROOT/budgeted/users/";
	//txt files only supported type
	String fileType = ".txt";
	//Used to separate user information in the file.
	String seperator = "^";
	Date now = new Date();
	//standard budget for item cost, to be configured
	int c20 = 1;
	int c10 = 3;
	//Using a calendar object to figure out the days of the week.
	Calendar cal2 = new Calendar.Builder().build();
	
	//resets monday,friday
	String[] toWrite = {""+0,""+0,""+c20,""+c10};
	
	void setWrite(String[] written, String... args) {
		if (args.length == written.length) {
			for (int i = 0; i < args.length; i++) {
				written[i] = args[i];
			}			
		} else {
			for (int i = 0; i < written.length; i++) {
				written[i] = args[0];
			}
		}
	}
	//different methods for finding the corresponding day of the week.
	long getMonday() {
		Calendar cal = new Calendar.Builder().build();
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		cal.setTime(new Date());
		cal.set(Calendar.DAY_OF_WEEK,Calendar.MONDAY);
		cal.set(Calendar.AM_PM,Calendar.AM);
		cal.set(Calendar.HOUR,0);
		cal.set(Calendar.MINUTE,0);
		cal.set(Calendar.SECOND,0);
		long result = cal.getTime().toInstant().getEpochSecond();
		return result;
	}
	
	long getThursday() {
		Calendar cal = new Calendar.Builder().build();
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		cal.setTime(new Date());
		cal.set(Calendar.DAY_OF_WEEK,Calendar.THURSDAY);
		cal.set(Calendar.AM_PM,Calendar.PM);
		cal.set(Calendar.HOUR,11);
		cal.set(Calendar.MINUTE,59);
		cal.set(Calendar.SECOND,59);
		long result = cal.getTime().toInstant().getEpochSecond();
		return result;
	}
	
	long getFriday() {
		Calendar cal = new Calendar.Builder().build();
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		cal.setTime(new Date());
		cal.set(Calendar.DAY_OF_WEEK,Calendar.FRIDAY);
		cal.set(Calendar.AM_PM,Calendar.AM);
		cal.set(Calendar.HOUR,0);
		cal.set(Calendar.MINUTE,0);
		cal.set(Calendar.SECOND,0);
		long result = cal.getTime().toInstant().getEpochSecond();
		return result;
	}
	
	long getSunday() {
		Calendar cal = new Calendar.Builder().build();		
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		cal.setTime(new Date());
		cal.set(Calendar.DAY_OF_WEEK,Calendar.SUNDAY);
		cal.set(Calendar.AM_PM,Calendar.PM);
		cal.set(Calendar.HOUR,11);
		cal.set(Calendar.MINUTE,59);
		cal.set(Calendar.SECOND,59);
		long result = cal.getTime().toInstant().getEpochSecond();
		return result;
	}
%>