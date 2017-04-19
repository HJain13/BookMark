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
@WebServlet("/app/DeleteBook")
public class DeleteBook extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeleteBook() {
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
		io.github.hjain13.Book books = new Book();
		
		String ISBN = request.getParameter("ISBN");

		PrintWriter out = response.getWriter();		
		String hiddenParam=request.getParameter("formSelect");
		if(hiddenParam.equals("1")){			
			try {
				String title = books.getTitle(ISBN, con.stmt);
				books.deleteEntry(ISBN, con.stmt);
				System.out.println("Deleted "+title);
				out.println("<script type='text/javascript'>alert('Deleted "+title+"!!');location.href='bookKeeping.jsp';</script>");			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println("<script type='text/javascript'>alert('Error Deleting!!');location.href='bookKeeping.jsp';</script>");
			}
		}
		else {
			try {
				String title = books.getTitle(ISBN, con.stmt);
				books.deleteFromEC(ISBN, con.stmt);
				System.out.println("Deleted "+title+" From EC");
				out.println("<script type='text/javascript'>alert('Deleted "+title+" From EC!!');location.href='bookKeeping.jsp';</script>");			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println("<script type='text/javascript'>alert('Error Deleting!!');location.href='bookKeeping.jsp';</script>");
			}			
		}
	}

}
