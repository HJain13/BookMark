package io.github.hjain13;
import java.sql.ResultSet;
import java.sql.Statement;

public class Customer {

	private String[] attrName = { "cid", "login_name", "password", "full_name", "address", "phone","plan","type" };
	private String tableName = "customer";
	public Customer() {
	}

	public void initCustomer(Statement stmt) throws Exception {
		String[] attrValue;
		attrValue = new String[] { "Tom", "123456", "Tom", "Shanghai", "4008823823","0","1" };
		this.newCustomer(attrValue, stmt);
		attrValue = new String[] { "Sam", "123456", "Sam", "Beijing", "4008823823", "1","0" };
		this.newCustomer(attrValue, stmt);
		attrValue = new String[] { "Amy", "123456", "Amy", "Xiamen", "4008823823", "1","0" };
		this.newCustomer(attrValue, stmt);
		attrValue = new String[] { "Tony", "123456", "Tony", "Nanjing", "4008823823", "2","0" };
		this.newCustomer(attrValue, stmt);
		attrValue = new String[] { "root", "root", "root", "Shanghai", "4008823823", "0","2" };
		this.newCustomer(attrValue, stmt);
		attrValue = new String[] { "feifei", "great", "lifeifei","Baoji", "123456789", "2","0" };
		this.newCustomer(attrValue, stmt);
	}

	public Boolean existCustomer(String attrValue, Statement stmt) throws Exception {
		String query;
		query = "select count(*) as c from customer where customer.login_name='" + attrValue + "';";
		ResultSet results;
		try {
			results = stmt.executeQuery(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}
		if (results.next()) {
			if (results.getInt("c") == 0) {
				return false;
			} else {
				return true;
			}
		}
		return false;
	}

	public void newCustomer(String[] attrValue0, Statement stmt) throws Exception {
		int cid = this.countCustomer(stmt);
		String[] attrValue = new String[] { String.valueOf(cid), "'"+attrValue0[0]+"'", "'"+attrValue0[1]+"'", "'"+attrValue0[2]+"'", "'"+attrValue0[3]+"'", "'"+attrValue0[4]+"'", "'"+attrValue0[5]+"'" , "'"+attrValue0[6]+"'" };
		Common com = new Common();
		com.newTuple(attrValue, tableName, attrName, stmt);
		Customer_Rate cr = new Customer_Rate();
		attrValue = new String[] {String.valueOf(cid),String.valueOf(cid),"true"};
		cr.newCustomer_Rate(attrValue, stmt);
	}

	public boolean loginCustomer(String login_name, String password, Statement stmt) throws Exception {
		ResultSet results;
		String[] sigmaAttr = { "login_name" };
		String[] sigmaValue = { "'"+login_name+"'" };
		results = this.showCustomer(sigmaAttr, sigmaValue, stmt);
		if (results.next()) {
			if (password.equals(results.getString("password")))
				return true;
			else
				return false;
		}
		return false;
	}

	public int getCid(String user, Statement stmt) throws Exception {
		String query;
		query = "select cid from customer where login_name=" + user + ";";
		System.out.println(query);
		ResultSet results;
		try {
			results = stmt.executeQuery(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}
		int cid = -1;
		if (results.next()) {
			cid = results.getInt("cid"); 
		}
		return cid;
	}
	
	public String getName(String user, Statement stmt) throws Exception {
		String query;
		query = "select full_name from customer where login_name=" + user + ";";
		System.out.println(query);
		ResultSet results;
		try {
			results = stmt.executeQuery(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}
		String fullName = "";
		if (results.next()) {
			fullName = results.getString("full_name"); 
		}
		return fullName;
	}
	public String getAddress(String user, Statement stmt) throws Exception {
		String query;
		query = "select address from customer where login_name=" + user + ";";
		System.out.println(query);
		ResultSet results;
		try {
			results = stmt.executeQuery(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}
		String address = "";
		if (results.next()) {
			address = results.getString("address"); 
		}
		return address;
	}
	
	public int getPlan(String user, Statement stmt) throws Exception {
		String query;
		query = "select plan from customer where login_name=" + user + ";";
		System.out.println(query);
		ResultSet results;
		try {
			results = stmt.executeQuery(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}
		int plan = 0;
		if (results.next()) {
			plan = results.getInt("address"); 
		}
		return plan;
	}	


	public void deleteCustomer(String cid, Statement stmt) throws Exception {
		String query;
		query = "delete from customer where customer.cid=";
		query += cid + ";";
		System.out.println(query);
		try {
			stmt.execute(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}
	}

	public void updateCustomer(String cid, String[] attr, String[] value, Statement stmt) throws Exception {
		Common com = new Common();
		com.updateTuple("cid", cid, attr, value, tableName, stmt);
	}

	public ResultSet showCustomer(String[] sigmaAttr, String[] sigmaValue, Statement stmt) throws Exception {
		Common com = new Common();
		return com.showTable(sigmaAttr, sigmaValue, tableName, stmt);
	}

	public int countCustomer(Statement stmt) throws Exception {
		Common com = new Common();
		return com.countTuple(tableName, stmt);
	}

}