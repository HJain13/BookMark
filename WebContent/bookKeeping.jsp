<!DOCTYPE html>
<%@ page language="java" import="io.github.hjain13.*, java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="en">
<head>
 	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Book Keeping | BookMark</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="slick/slick.css">
	<link rel="stylesheet" type="text/css" href="slick/slick-theme.css">    
	<link rel="stylesheet" href="base.css">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="resources/js/float-panel.js"></script>	
</head>
<body>
	<%
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
		if (name.equals("")) {
	%>
		<script type="text/javascript">
			alert("Please Login First !!");
			location.href="index.jsp";
		</script>
	<% 
		} 
		name_q = "'" + name + "'";
		
		io.github.hjain13.Connector con = new Connector();
		io.github.hjain13.Customer customers = new Customer();
		io.github.hjain13.Common com = new Common();
		io.github.hjain13.Customer_Rate customer_rates = new Customer_Rate();
		int cid = customers.getCid(name_q, con.stmt);
		String fullName = customers.getName(name_q, con.stmt);
		String address = customers.getAddress(name_q, con.stmt);
	%>

	<!-- Header -->
	<nav>
		<div class="float-panel" data-top="0" data-scroll="500">
			<div style="text-align:right;max-width:1360px;margin:0 auto;">
				<a href="#" style="float:left;">
					<i class="fa f fa-bookmark-o"></i>&nbsp;
					<em style="font:bold 20px Segoe UI;letter-spacing:1px;">BookMark</em>
				</a>
				<a href="browsebook.jsp"><i class="fa fa-search"></i></a>
				<a href="user.jsp">Users</a>
				<% if(name.equals("root")){ %>		
				<a href="newbook.jsp">New Books</a>	
				<% } %>
				<a>Welcome, <%=name%></a>
				<a href="orders.jsp"><i class="fa fa-shopping-cart"></i></a>											
				<a id="logout">Logout</a>&nbsp; 
			</div>
		</div>
	</nav>	
	<script type="text/javascript">
		$("#logout").click(function(e) {
			document.cookie = "loginname=";
			location.href="index.jsp";
		});
	</script>
	<div id="main-container" class="top-space">
		<div class="col-1">
			<h3>Add Book to Catalog<hr></h3>
			<form action="AddBook" method="get">
				<input type="text" name = "ISBN" placeholder="ISBN">			
				<input type="text" name = "title" placeholder="Title">
				<input type="text" name = "author" placeholder="Author"><br/>				
				<input type="text" name = "publisher" placeholder="Publisher">
				<input type="text" name = "publish_year" placeholder="Publishing Year">
				<input type="text" name = "price" placeholder="Price"><br/>
				<input type="text" name = "format" placeholder="Format">	
				<input type="text" name = "keywords" placeholder="Keywords">					
				<input type="text" name = "plan" placeholder="Plan"><br/>					
				<input type="text" name = "subject" placeholder="Subject">	
				<input type="submit" class="button-primary" value="Add" ><br/> 										
			</form>

			<h3>Delete Book from Catalog<hr></h3>
			<form class="bottom-space" action="DeleteBook" method="post">
			<div class="col-4">ISBN:</div>
			<input type="text" float="left" style="margin-right:50px" name = "ISBN" >
			<input type="submit" class="button-primary" value="Delete" ><br/> 									
			</form>			
		</div>
	</div>
	<div class="footer">
		<div class="col-2">
			<h4>About US</h4>
			<p>The BookKeepers </p>
			<p>Mail : example@example.com </p>
		</div>
		<div class="col-2">
			<h4>About Website</h4>
			<p>BUILT FOR ALL FUNCTIONALITY !! </p>
		</div>
	</div>		
</body>
</html>
