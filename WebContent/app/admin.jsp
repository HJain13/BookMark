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
		jQuery(document).ready(function(){
	        jQuery('#hideshow').on('click', function(event) {        
	             jQuery('#tableContent').toggle('show');
	        });
	    });		
	</script>
	<div id="main-container" class="top-space">
		<div class="col-1">
			<form action="DeleteUser" method="post">
				<h3>Remove User</h3>
				<div class="col-4">Username:</div>
				<input type="text" float="left" style="margin-right:50px" name = "username" >
				<input type="submit" class="button-primary" value="Delete" ><br/> 
			</form>
			
			<form action="AddUser" method="post">
				<h3>Add User</h3>
				<div class="col-4">
					<label>Username: </label><br/>
					<label>Full Name: </label> 			
					<label>Plan: </label><br/>
					<label>Password :</label>	
					<label>Shipping Address: </label><br/>
					<label>Type: </label>				
					<label>Contact No:</label>
				</div>
				<input type="text" name = "username" ><br/>		
				<input type="text" name = "name" ><br/>	
				<select name="plan">
					<option value="0">Basic</option>
					<option value="1">Standard</option>
					<option value="2">Premium</option>
				</select>	<br/>
				<input type="text" name = "password" ><br/>
				<input type="text" name = "address" ><br/>	
				<select name="type">
					<option value="0">Standard</option>
					<option value="1">BookKeeper</option>
					<option value="2">Admin</option>
				</select>		<br/>	
				<input type="text" name = "phone" ><br/>				
				<input type="submit" class="button-primary" value="Add" ><br/> 			
			</form>
			<input type='button' id='hideshow' value='Hide/Show Users'>	
			<div id='tableContent'>		
				<h3>All Users ( Just for Testing Browsing ): </h3>
				<table>
					<tr>
						<th>CId</th>
						<th>User Name</th>
						<th>Password</th>
						<th>Full Name</th>
						<th>Address</th>
						<th>Phone</th>
						<th>Plan</th>
						<th>Type</th>
					</tr>
					<%
						results = customers.browseCustomer(con.stmt);
						while (results.next()) {
					%>
					<tr>
						<td><%=results.getString("cid")%></td>
						<td><%=results.getString("login_name")%></td>
						<td><%=results.getString("password")%></td>
						<td><%=results.getString("full_name")%></td>
						<td><%=results.getString("address")%></td>
						<td><%=results.getString("phone")%></td>
						<td><%=results.getInt("plan")%></td>
						<td><%=results.getInt("type")%></td>
					</tr>
					<%
						}
					%>
					
				</table>
				<br/><br/>		
				
			</div>
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