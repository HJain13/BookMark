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
@WebServlet("/app/DeleteUser")
public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeleteUser() {
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
			System.out.println("Error");
			e1.printStackTrace();
		}
		io.github.hjain13.Customer customers = new Customer();
		io.github.hjain13.Common com = new Common();
		io.github.hjain13.Customer_Rate crate = new Customer_Rate();
		io.github.hjain13.Feedback_Rate frate = new Feedback_Rate();
		io.github.hjain13.Feedback fback = new Feedback();			
		String userName = request.getParameter("username") ;
		int cid=0;
		try {
			cid = customers.getCid("'"+userName+"'", con.stmt);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String id = ""+cid;
		PrintWriter out = response.getWriter();		
		try {
			crate.deleteCustomer_RateByCid(id, con.stmt);
			frate.deleteFeedback_RateByCid(id, con.stmt);
			fback.deleteEntryByCid(id, con.stmt);			
			customers.deleteCustomer(id, con.stmt);
			System.out.println("Deleted "+userName);
			out.println("<script type='text/javascript'>alert('Deleted "+userName+"!!');location.href='admin.jsp';</script>");			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.println("<script type='text/javascript'>alert('Error Deleting!!');location.href='admin.jsp';</script>");
		}
	}

}
