package io.github.hjain13;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Scanner;

public class testdriver {

	/**
	 * @param args
	 */

	public static void main(String[] args) {
		
		try {

			Connector con = new Connector();
			Common com = new Common();
			Scanner sc = new Scanner(System.in);
			Customer customers = new Customer();
			Book books = new Book();
			Orders orders = new Orders();
			Feedback feedbacks = new Feedback();
			Feedback_Rate feedback_rates = new Feedback_Rate();
			Customer_Rate customer_rates = new Customer_Rate();

			String[] attrName, attrValue, sigmaAttr, sigmaValue;
			ResultSet results;
			String curLogin = null;
			int curCid = 0;

			Calendar ca = Calendar.getInstance();
			int year = ca.get(Calendar.YEAR);
			int month = ca.get(Calendar.MONTH) + 1;
			int day = ca.get(Calendar.DATE);
			String date = "'" + year + "-" + month + "-" + day + "'";

			//com.initTable(con.stmt);
			
			String ISBN = "'0133760065'";
			String a1 = "Xiaoming";
			String a2 = "Xiaohong";
			//String a3 = com.degree(a1, a2, con.stmt);
			//String user = "'Tom'";
			ResultSet resultFR = com.mostTrustUser(con.stmt);
			//Boolean a = feedbacks.existFeedback(ISBN, user, con.stmt);
			
			while (resultFR.next()) {}
			while (true) {

				com.display();
				int func = sc.nextInt();

				if (func == 0) {
					System.out.println("Bye bye!");
					break;
				}

				switch (func) {
				case 1:

					int cid = customers.countEntry(con.stmt);
					attrValue = new String[] { String.valueOf(cid), "", "" };

					System.out.println("Enter user name");
					if (sc.hasNext())
						attrValue[1] = "'" + sc.next() + "'";

					System.out.println("Enter password");
					if (sc.hasNext())
						attrValue[2] = "'" + sc.next() + "'";

					customers.newEntry(attrValue, con.stmt);

					break;
				case 2:

					sigmaValue = new String[] { "" };
					sigmaAttr = new String[] { "login_name" };
					String password = "";

					System.out.println("Enter user name");
					if (sc.hasNext())
						sigmaValue[0] = "'" + sc.next() + "'";

					results = customers.showCustomer(sigmaAttr, sigmaValue,
							con.stmt);

					if (results.next()) {
						password = results.getString("password");
						curCid = results.getInt("cid");
					}
					System.out.println("Enter password");
					if (sc.hasNext()) {
						String tempStr = sc.next();
						if (password.equals(tempStr)) {
							curLogin = sigmaValue[0].substring(1,
									sigmaValue[0].length() - 1);
							System.out.println("Welcome " + curLogin);
						}

					}

					break;
				case 3:

					System.out
							.println("Query Format: nothing -> null or statement -> subject like '%computer%' or subject like '%children%'");
					String queryStmt = "";

					while (queryStmt.equals("")) {
						queryStmt = sc.nextLine();
					}
					if (queryStmt.equals("null"))
						queryStmt = "";
					System.out
							.println("Sort: 0 null, 1 by publish year, 2 by feedback, 3 by trusted feedback");
					int sortType = 0;
					if (sc.hasNext())
						sortType = Integer.valueOf(sc.next());

					if (curLogin == null) {
						System.out.println("Sign In First");
						sortType = 0;
					}
					//results = books.browseBook(queryStmt, sortType, con.stmt);
					//com.showResultSet(results);
					break;

				case 4:

					if (curLogin == null) {
						System.out.println("Sign In First");
						break;
					}

					int oid = orders.countEntry(con.stmt);
					attrValue = new String[] { String.valueOf(oid), "",
							String.valueOf(curCid), date };
					System.out.println("Enter the ISBN");
					if (sc.hasNext()) {
						attrValue[1] = sc.next();
					}
					orders.newOrders(attrValue, con.stmt);

					break;
				case 5:

					System.out.println("Enter the ISBN");
					ISBN = "";
					if (sc.hasNext()) {
						ISBN = sc.next();
					}
					attrName = new String[] { "copies" };
					attrValue = new String[] { "" };
					System.out.println("Enter the copies");
					if (sc.hasNext()) {
						attrValue[0] = sc.next();
					}
					books.updateEntry("ISBN", ISBN, attrName, attrValue,
							con.stmt);

					break;

				case 6:

					int fid = feedbacks.countEntry(con.stmt);

					attrValue = new String[] { String.valueOf(fid), "",
							String.valueOf(curCid), "", "", date };
					System.out.println("Enter the ISBN and Comment and Rate");
					if (sc.hasNext())
						attrValue[1] = "'" + sc.next() + "'";
					if (sc.hasNext())
						attrValue[3] = "'" + sc.next() + "'";
					if (sc.hasNext())
						attrValue[4] = sc.next();
					feedbacks.newEntry(attrValue, con.stmt);

					break;

				case 7:

					attrValue = new String[] { "", String.valueOf(curCid), "" };
					System.out.println("Enter the fid and Rate");
					if (sc.hasNext())
						attrValue[0] = sc.next();
					if (sc.hasNext())
						attrValue[2] = sc.next();

					feedback_rates.newEntry(attrValue, con.stmt);
					break;

				case 8:

					attrValue = new String[] { String.valueOf(curCid), "", "" };
					System.out.println("Enter the cid and trusted");
					if (sc.hasNext())
						attrValue[1] = sc.next();
					if (sc.hasNext())
						attrValue[2] = sc.next();

					customer_rates.newEntry(attrValue, con.stmt);
					break;

				case 9:

					System.out.println("Enter the ISBN and display number");
					ISBN = "";
					if (sc.hasNext())
						ISBN = "'" + sc.next() + "'";
					String number = "10";
					if (sc.hasNext())
						number = sc.next();
					results = com.mostUseFB(ISBN, number, con.stmt);
					com.showResultSet(results);
					break;

				case 10:

					results = com.suggest(String.valueOf(curCid), con.stmt);
					com.showResultSet(results);
					break;

				case 11:

					break;

				case 12:

					System.out.println("Enter 0 book 1 author 2 publisher");
					sortType = 0;
					if (sc.hasNext())
						sortType = Integer.valueOf(sc.next());

					String name = "ISBN";
					switch (sortType) {
					case 0:
						name = "ISBN";
						break;
					case 1:
						name = "author";
						break;
					case 2:
						name = "publisher";
						break;
					default:
						break;
					}

					System.out.println("Enter display number");
					number = "10";
					if (sc.hasNext())
						number = sc.next();
					results = com.mostPopular(name, number, con.stmt);
					com.showResultSet(results);

					break;

				case 13:

					System.out
							.println("Enter 0 most trusted user 1 most useful user");
					sortType = 0;
					if (sc.hasNext())
						sortType = Integer.valueOf(sc.next());

					results = null;
					switch (sortType) {
					case 0:
						results = com.mostTrustUser(con.stmt);
						break;
					case 1:
						results = com.mostUsefulUser(con.stmt);
						break;
					default:
						break;
					}

					com.showResultSet(results);
					break;

				default:
					break;
				}

				System.out.println();

			}

			sc.close();
			con.closeConnection();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
