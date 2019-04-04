package com.socialmedia.helper;

public class StringOperation {

	public static String getCapitalize(String name) {
		String firstName=name.substring(0,name.indexOf(" "));
		String lastName=name.substring(name.indexOf(" ")+1);
		
		firstName=firstName.substring(0,1).toUpperCase()+firstName.substring(1).toLowerCase();
		lastName=lastName.substring(0,1).toUpperCase()+lastName.substring(1).toLowerCase();
		
		
		return firstName+" "+lastName;
	}
}
