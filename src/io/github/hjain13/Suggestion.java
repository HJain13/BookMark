package io.github.hjain13;

import java.sql.Statement;

public class Suggestion {

	private String[] attrName = { "username",  "suggestion" };
	private String tableName = "suggestion";

	public Suggestion() {
	}

	public void init(Statement stmt) throws Exception {
		String[] attrValue;
		attrValue = new String[] { "'riya'", "'harrypotter'" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'himesh'", "'Introduction to Algorithm part 2'"};
		this.newEntry(attrValue, stmt);
	}

	public void newEntry(String[] attrValue, Statement stmt) throws Exception {
		Common com = new Common();
		com.newTuple(attrValue, tableName, attrName, stmt);		
	}
}

