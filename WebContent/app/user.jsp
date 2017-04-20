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
			location.href="index.jsp";
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
		
		
		String _trust = (String)request.getParameter("_trust");
		if (_trust != null && !_trust.equals("null")) {
			String _name = (String)request.getParameter("_name");
			customer_rates.update(cid, _name, _trust, con.stmt);
	%>
		<script type="text/javascript">
			alert("Update Customer Rate Successful !! ");
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
			location.href="index.jsp";
		});
	</script>
	<div id="main-container" class="top-space bottom-space">
		<div class="col-1">
			<h3>All Users : </h3>
			<table border="1">
				<thead>
					<tr>
						<th>&nbsp;Customer&nbsp;</th>
						<th>&nbsp;Trust Him / Her&nbsp;</th>
						<th>&nbsp;Trust Change&nbsp;</th>
					</tr>
				</thead>
				<tbody>
			<%
				results = customer_rates.showCustomer_Rate(cid, con.stmt);
				while (results.next()) {
			%>
					<tr>
						<td>&nbsp;<%=results.getString("customer")%></td>
						<td><%=results.getBoolean("trusted")%></td>
						<td>
							<form action="user.jsp" method="post" class="noMargin table-form">
								<input type="hidden" name="_name" value=<%="'" + results.getString("customer")+"'"%>/>
								<label style="float: left; margin-right:10px; width: 50px">True:</label><input type="radio" name="_trust" value="true" /><br/>
								<label style="float: left; margin-right:10px; width: 50px">False:</label><input type="radio" name="_trust" value="false" />
								<%	if (results.getString("customer").equals(name)) {	%>
									&nbsp;<button type="submit" class="button-primary tableButton" disabled="disabled">Submit</button>
								<%	} else {	%>
									<button type="submit" class="button-primary tableButton">Submit</button>
								<% 	}	%>
								<br/>
								<label style="float: left; margin-right:10px; width: 50px">Null:</label><input type="radio" name="_trust" value="null" checked="checked" /><br/>							
							</form>
						</td>
					</tr>
			<%
				}
			%>
			</table>
			<br/>
			<hr/>
			<br/>
			<h3>Most Trusted User : </h3>
			<table>
				<tr>
					<th>&nbsp;Customer&nbsp;</th>
					<th>&nbsp;Trust Score&nbsp;</th>
				</tr>
			<%
				results = com.mostTrustUser(con.stmt);
				while (results.next()) {
			%>
				<tr>
					<td><%=results.getString("login_name")%></td>
					<td><%=results.getDouble("score")%></td>
				</tr>
			<%
				}
			%>
			</table>
			<br/>
			<hr/>
			<br/>
			<h3>Most Useful User : </h3>
			<table>
				<tr>
					<th>&nbsp;Customer&nbsp;</th>
					<th>&nbsp;Useful Score&nbsp;</th>
				</tr>
			<%
				results = com.mostUsefulUser(con.stmt);
				while (results.next()) {
			%>
				<tr>
					<td><%=results.getString("login_name")%></td>
					<td><%=results.getDouble("score")%></td>
				</tr>
			<%	}	%>
			</table>
			<%	con.closeConnection();	%>
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
