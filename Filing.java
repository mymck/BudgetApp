package Budget;

import java.io.*;
public class Filing {
	//a main function for testing
	public static void main(String... args) {
		String path = "./ouput1.txt";
		writeTo(path,"A long 111 string that can be written");
		System.out.println(readFrom(path));
	}
	
	byte[] file;
	
	public Filing(){}
	//Used to save user information
	public static void writeTo(String path, String output){
		FileWriter out = null;
		
		try {
			out = new FileWriter(path);
			out.write(output);
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (out != null) {
				try {out.close();}catch(Exception e){
					System.out.println(e.getMessage());
				}
			}
		}
	}
	//File comes in as a stream of characters but return it is a string
	public static String readFrom(String path){
		FileReader in = null;
		String result = "";
		
		try {
			in = new FileReader(path);
			int c;
			while ((c = in.read()) != -1) {
				result += (char)c;
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (in != null) {
				try {in.close();}catch(Exception e){
					System.out.println(e.getMessage());
				}
			}
			return result;
		}
	}
	//functions like these are to avoid additional imports on files that need this.
	public static boolean exists(String path){
		File result = new File(path);
		return result.exists();
	}
	
}