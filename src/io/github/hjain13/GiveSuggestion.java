package io.github.hjain13;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GiveSuggestion
 */
@WebServlet("/app/GiveSuggestion")
public class GiveSuggestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GiveSuggestion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = (String) request.getParameter("name");
		String suggestion = (String) request.getParameter("suggestion");
		io.github.hjain13.Connector con = null;
		PrintWriter out = response.getWriter();			
		try {
			con = new Connector();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			Common com = new Common();
			String[] attrName = { "username", "suggestion"};	
			String[] attrValue = { "'"+username+"'" , "'"+suggestion+"'"};		
			String tableName = "suggestion";
				try {
					com.newTuple(attrValue, tableName, attrName, con.stmt);
					out.println("<script type='text/javascript'>alert('Submitted Suggestion!!');location.href='profile.jsp';</script>");								
				} catch (Exception e) {
					e.printStackTrace();
				}
			} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Error");
		}
	}

}
