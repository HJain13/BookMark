package io.github.hjain13;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddBook
 */
@WebServlet("/app/AddBook")
public class AddBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddBook() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		io.github.hjain13.Connector con = null;
		try {
			con = new Connector();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			System.out.println("Error");
			e1.printStackTrace();
		}
		io.github.hjain13.Book books = new Book();
		PrintWriter out = response.getWriter();				
		String hiddenParam=request.getParameter("formSelect");
		if(hiddenParam.equals("1")){
			String ISBN = request.getParameter("ISBN");
			String title = request.getParameter("title");
			String author = request.getParameter("author");
			String publisher = request.getParameter("publisher");
			String publish_year = request.getParameter("publish_year");
			String price = request.getParameter("price") ;
			String format = request.getParameter("format") ;
			String keywords = request.getParameter("keywords") ;
			String plan = request.getParameter("plan") ;		
			String subject = request.getParameter("subject") ;	
			String[] attrValue = { "'"+ISBN+"'", "'"+title+"'", "'"+author+"'", "'"+publisher+"'", "'"+publish_year+"'", "1", price, "'"+format+"'", "'"+keywords+"'", "'"+plan+"'", "'"+subject+"'" };		
			
			try {
				books.newEntry(attrValue, con.stmt);
				System.out.println("Added Book!!");			
				out.println("<script type='text/javascript'>alert('Added Book!!');location.href='bookKeeping.jsp';</script>");			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println("<script type='text/javascript'>alert('Error Adding!!');location.href='bookKeeping.jsp';</script>");
			}			
		} else if(hiddenParam.equals("2")){
			try {
				String ISBN = request.getParameter("ISBN");
				String title = books.getTitle(ISBN, con.stmt);				
				books.addToEC(ISBN, con.stmt);
				System.out.println("Added "+title+" to Editor Choice Category!!");			
				out.println("<script type='text/javascript'>alert('Added "+title+" to Editor Choice Category!!');location.href='bookKeeping.jsp';</script>");			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println("<script type='text/javascript'>alert('Error Adding to Editor Choice Category!!');location.href='bookKeeping.jsp';</script>");
			}	
		}
		

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
