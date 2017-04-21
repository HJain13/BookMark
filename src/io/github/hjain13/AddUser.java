package io.github.hjain13;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteUser
 */
@WebServlet("/app/AddUser")
public class AddUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		io.github.hjain13.Connector con = null;
		try {
			con = new Connector();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		io.github.hjain13.Customer customers = new Customer();
		String loginname = (String)request.getParameter("username");
		Boolean exist = false;
		try {
			exist = customers.existCustomer(loginname, con.stmt);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		PrintWriter out = response.getWriter();	
		if (exist) {
			out.println("<script type='text/javascript'>alert('This Login Name has been used !!');</script>");
		} else {
			String password = (String)request.getParameter("password");
			String fullname = (String)request.getParameter("name");
			String address = (String)request.getParameter("address");
			String phone = (String)request.getParameter("phone");
			String plan = request.getParameter("plan");
			String type = request.getParameter("type");			
			String[] attrValue = new String[] {loginname, password, fullname, address, phone, plan, type};
			try {
				customers.newEntry(attrValue, con.stmt);
				System.out.println("Added "+fullname);
				out.println("<script type='text/javascript'>alert('Added "+fullname+"!!');location.href='admin.jsp';</script>");			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println("<script type='text/javascript'>alert('Error Adding!!');location.href='admin.jsp';</script>");
			}
		}
	}
}
