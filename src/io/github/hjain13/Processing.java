package io.github.hjain13;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Processing
 */
@WebServlet("/app/Processing")
public class Processing extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Processing() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Cookie[] cookies = request.getCookies();
		String name="", name_q="";
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				
				if (cookie.getName().equals("loginname")) {
					name = cookie.getValue();
					break;
				}
			}
		}
		name_q = "'" + name + "'";		
		io.github.hjain13.Connector con = null;
		try {
			con = new Connector();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		io.github.hjain13.Customer customers = new Customer();

		ResultSet results = null;
		String[] sigmaAttr = { "login_name" }, sigmaValue = { name_q };
		try {
			results = customers.showCustomer(sigmaAttr, sigmaValue, con.stmt);			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("error");			
		}
		int cid = 0, ptype = 0, type = 0;
		String fullName = "", address = "", loginName = "";
		try {
			System.out.println("enter Set values Successfully!");				
			if (results.next()) {
				cid = results.getInt("cid");				
				ptype = results.getInt("plan");		
				fullName = results.getString("full_name");
				address = results.getString("address");
				loginName = results.getString("login_name");				
				type = results.getInt("type");
				System.out.println("Set values Successfully!" + cid + ptype + fullName + address + loginName + type);				
			
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		HttpSession s=request.getSession();
		s.setAttribute("cid",cid);
		s.setAttribute("ptype",ptype);
		s.setAttribute("type",type);		
		s.setAttribute("address",address);
		s.setAttribute("fullName",fullName);
		s.setAttribute("loginName",loginName);			
		System.out.println("Set Successfully!");
		response.sendRedirect("home.jsp");	
	}

}
