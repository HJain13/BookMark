<!DOCTYPE html>
<%@ page language="java" import="io.github.hjain13.*, java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="en">
<head>
 	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Orders | BookMark</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../slick/slick.css">
	<link rel="stylesheet" type="text/css" href="../slick/slick-theme.css">    
	<link rel="stylesheet" href="../base.css">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="../resources/js/float-panel.js"></script>	
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
			location.href="index.html";
		</script>
	<% 
		} 
		name_q = "'" + name + "'";
		
		io.github.hjain13.Connector con = new Connector();
		io.github.hjain13.Book books = new Book();
		io.github.hjain13.Feedback feedbacks = new Feedback();
		io.github.hjain13.Feedback_Rate feedback_rates = new Feedback_Rate();
		io.github.hjain13.Customer customers = new Customer();
		io.github.hjain13.Orders orders = new Orders();

		ResultSet results;
		String[] sigmaAttr = { "login_name" }, sigmaValue = { name_q };
		results = customers.showCustomer(sigmaAttr, sigmaValue, con.stmt);		
		int cid = 0, ptype = 0, type = 0;
		String fullName = "", address = "";
		if (results.next()) {
			cid = results.getInt("cid");
			ptype = results.getInt("plan");
			fullName = results.getString("full_name");
			address = results.getString("address");
			type = results.getInt("type");
		}			
		
		String ISBN = (String)request.getParameter("ISBN");
		if (ISBN != null && !ISBN.equals("")) {
			ISBN = "'" + ISBN + "'";
			String[] order_value = new String[] {ISBN, String.valueOf(cid), (String)request.getParameter("order_copies")};
			boolean order_succ = orders.newOrders(order_value, con.stmt);
			if (order_succ) {
	%>
			<script type="text/javascript">
				alert("New Order Successful !! ");
			</script>
	<%
			} else {
	%>
			<script type="text/javascript">
				alert("Can not provide so many books !! ");
			</script>
	<%
			}
	%>
			<script type="text/javascript">
				location.href="onebook.jsp?ISBN=" + <%=ISBN%>;
			</script>
	<%
		}
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
				<% if(type >= 1){ %>		
				<a href="bookKeeping.jsp">Book Mgmt</a>	
				<% } %>				
				<% if(type == 2){ %>		
				<a href="admin.jsp">User Mgmt</a>	
				<% } %>				
				<a href="profile.jsp">Welcome, <%=name%></a>
				<a href="orders.jsp"><i class="fa fa-shopping-cart"></i></a>											
				<a id="logout">Logout</a>&nbsp; 
			</div>
		</div>
	</nav>
	<script type="text/javascript">
		$("#logout").click(function(e) {
			document.cookie = "loginname=";
			location.href="../index.jsp";
		});
	</script>
	<div id="main-container">
		<div class="col-1">		
			<h3>My Orders : </h3>
			<table border="1">
				<tr>
					<th>Order ID</th>
					<th>Date</th>
					<th>ISBN</th>
					<th>Amount</th>
				</tr>
			<%
				results = orders.showOrders(cid, con.stmt);
				while (results.next()) {
			%>
				<tr>
					<td><%=results.getInt("oid")%></td>
					<td><%=results.getString("buy_date")%></td>
					<td><%=results.getString("ISBN")%></td>
					<td><%=results.getInt("amount")%></td>
				</tr>
			<%
				}
			%>
			</table>
			
			<%
				con.closeConnection();
			%>
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
