<!DOCTYPE html>
<%@ page language="java" import="io.github.hjain13.*, java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="en">
<head>
 	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>BookMark | Online Book Store</title>
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
		<form action="DeleteUser" method="post">
			<h3>Remove User</h3>
			<div class="col-4">Username:</div>
			<input type="text" float="left" style="margin-right:50px" name = "username" >
			<input type="submit" class="button-primary" value="Delete" ><br/> 
			</form>
			
		<form action="addUser.jsp" method="get">
			<h3>Add User</h3>
			<div class="col-4">
				<label>Username: </label>
				<label>Full Name: </label> 
				<label>Plan: </label>
				<label>Password :</label>	
				<label>Shipping Address: </label>
				Contact No:
			</div>
			<input type="text" name = "username" ><br/>			
			<input type="text" name = "name" ><br/>	
			<input type="text" name = "plan" ><br/>
			<input type="text" name = "password" ><br/>
			<input type="text" name = "address" ><br/>	
			<input type="text" name = "phone" ><br/>
			<input type="submit" class="button-primary" value="Add" ><br/> 			
		</form>
	</div>
</body>
</html>