package io.github.hjain13;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;

public class Orders implements basic{

	private String[] attrName = { "oid", "ISBN", "cid", "buy_date", "amount" };
	private String tableName = "orders";

	public Orders() {
	}

	public void init(Statement stmt) throws Exception {

		String[] attrValue;

		attrValue = new String[] { "'0133760065'", "0", "'2015-3-20'", "3" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'0133760065'", "0", "'2015-3-22'", "2" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'0133760065'", "2", "'2015-3-20'", "5" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'9787500794486'", "1", "'2015-4-20'", "1" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'9787500794486'", "0", "'2015-4-20'", "2" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'9787111407010'", "1", "'2015-4-20'", "3" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'9787500794486'", "4", "'2015-4-20'", "2" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'747266093'", "4", "'2015-4-20'", "2" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'515130044'", "1", "'2015-4-20'", "1" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'747266093'", "1", "'2015-4-20'", "1" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'9780553841008'", "1", "'2015-4-20'", "1" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'123456'", "1", "'2015-4-20'", "1" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'747266093'", "5", "'2015-6-10'", "2" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'515130044'", "5", "'2015-6-20'", "3" };
		this.newEntry(attrValue, stmt);
		attrValue = new String[] { "'0446699004'", "5", "'2015-6-20'", "2" };
		this.newEntry(attrValue, stmt);
	}
	
	public void newEntry(String[] attrValue, Statement stmt) throws Exception {
		int oid = this.countEntry(stmt);
		String[] tempValue = new String[] { String.valueOf(oid), attrValue[0], attrValue[1], attrValue[2], attrValue[3] };
		Common com = new Common();
		com.newTuple(tempValue, tableName, attrName, stmt);
	}
	
	public boolean newOrders(String[] attrValue, Statement stmt) throws Exception {
		Book books = new Book();
		String[] sigmaAttr = { "ISBN" };
		String[] sigmaValue = { attrValue[0] };
		ResultSet resultTable = books.showEntry(sigmaAttr, sigmaValue, stmt);

		int copies = 0;
		if (resultTable.next())
			copies = Integer.valueOf(resultTable.getInt("copies"));
		copies -= Integer.valueOf(attrValue[2]);
		if (copies < 0)
			return false;

		String[] tempAttr = { "copies" };
		String[] tempValue = { String.valueOf(copies) };
		books.updateEntry("ISBN", attrValue[0], tempAttr, tempValue, stmt);
		Calendar ca = Calendar.getInstance();
		int year = ca.get(Calendar.YEAR);
		int month = ca.get(Calendar.MONTH) + 1;
		int day = ca.get(Calendar.DATE);
		String date = "'" + year + "-" + month + "-" + day + "'";
		int oid = this.countEntry(stmt);
		tempValue = new String[] { String.valueOf(oid), attrValue[0], attrValue[1], date, attrValue[2] };

		Common com = new Common();
		com.newTuple(tempValue, tableName, attrName, stmt);
		return true;
	}

	public ResultSet showOrders(int cid, Statement stmt) throws Exception {

		String query = "";
		query = "select * from orders where cid=" + String.valueOf(cid) + " order by buy_date;";
		ResultSet results;
		try {
			results = stmt.executeQuery(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}
		return results;
	}

	public String[] getAttrName() {
		return attrName;
	}

	public void setAttrName(String[] attrName) {
		this.attrName = attrName;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public int countEntry(Statement stmt) throws Exception {

		Common com = new Common();
		int count = com.countTuple(tableName, stmt);
		return count;
	}
}
