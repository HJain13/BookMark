<!DOCTYPE html>
<%@ page language="java" import="io.github.hjain13.*, java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="en">
<head>
 	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>BookMark | Online Book Store</title>
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
			location.href="../index.jsp";
		</script>
	<% 
		} 
		name_q = "'" + name + "'";
		
		io.github.hjain13.Connector con = new Connector();
		io.github.hjain13.Customer customers = new Customer();
		io.github.hjain13.Common com = new Common();
		io.github.hjain13.Customer_Rate customer_rates = new Customer_Rate();
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
	%>

	<!-- Header -->
	<nav>
		<div class="float-panel" data-top="0" data-scroll="500">
			<div style="text-align:right;max-width:1360px;margin:0 auto;">
				<a href="home.jsp" style="float:left;">
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
	<div id="main-container" class="top-space">
		<div class="col-1">
			<h3>My Profile</h3>
			<hr>			
			<div class="col-4">
				Name <br/>
				User Name <br/>
				Plan of User <br/>
				User Type<br/>
				Address <br/>			
			</div>
			<div class="col-a">
				<%=fullName%><br/>			
				<%=name%><br/>
				<%=ptype%><br/>
				<% if (type == 0) out.print("Primary");
				else if (type == 1) out.print("Book Keeper");		
				else if (type == 2) out.print("Administratior");			
				else out.print("Alien :o ");				
				%><br/>							
				<%=address%><br/>			
			</div>
					<br>
		</div><br>		
	<a href="orders.jsp"><input type="button" class="button-primary" value="Show My Orders" ></a><br/> 			
		<div class="col-1">		
			<% if (type == 0) { %>
			<h3 class="top-space" >Give Suggestion for Addition to Book Catalog</h3><hr>
			<form action="GiveSuggestion" style="width:1000px;" method="post">
			<br><br>			
  			<input type="hidden" name="name" value="<%=name%>">			
			<input type="text" class="col-1" style="margin-right:50px" name = "suggestion" >
			<input type="submit" class="button-primary col-10" value="Suggest" ><br/> 									
			</form>
			<% } %>
			<% if (type > 0) { %>
				<h3 class="top-space">Suggestion from users: </h3>
				<table>
					<tr>
						<th>User Name</th>
						<th>Suggestion</th>
					</tr>
					<%
						results = com.suggestions(con.stmt);
						while (results.next()) {
					%>
					<tr>
						<td><%=results.getString("username")%></td>
						<td><%=results.getString("suggestion")%></td>
					</tr>
					<%
						}
					%>
					
				</table>
				<br/><br/>	
			<% } %>			
		</div>			
		<br>
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
