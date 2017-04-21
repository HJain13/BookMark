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
		io.github.hjain13.Book books = new Book();
		io.github.hjain13.Feedback feedbacks = new Feedback();
		io.github.hjain13.Feedback_Rate feedback_rates = new Feedback_Rate();
		io.github.hjain13.Customer customers = new Customer();

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
		
		String ISBN = "'"+(String)request.getParameter("ISBN")+"'";

		String fr_rate_submit = request.getParameter("fr_rate");
		if (fr_rate_submit != null && !fr_rate_submit.equals("-1")) {
			String fid_submit = request.getParameter("fid");
			String[] FR_val = new String[] {fid_submit, String.valueOf(cid), fr_rate_submit};
			feedback_rates.newEntry(FR_val, con.stmt);
		}

		String comment_submit = request.getParameter("fb_comment");
		if (comment_submit != null && !comment_submit.equals("")) {
			String fb_rate_submit = request.getParameter("fb_rate");
			String[] FB_val = new String[] {ISBN, String.valueOf(cid), comment_submit, fb_rate_submit};
			feedbacks.newEntry(FB_val, con.stmt);
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
	<div id="main-container" class="top-space">
		<div class="col-1 top-space">
			<h3>Book Detail : </h3>
			<table>
				<tr>
					<th>ISBN</th>
					<th>Title</th>
					<th>Author</th>
					<th>Publisher</th>
					<th>Publish_Year</th>
					<th>Copies</th>
					<th>Price</th>
					<th>Format</th>
					<th>Keywords</th>
					<th>Subject</th>
					<th>rate</th>
					<th>trust_rate</th>
				</tr>
				<%
					String emptyQuery = " ISBN = " + (String)request.getParameter("ISBN") + " ";
					results = books.browseEntry(emptyQuery, 4, name_q, con.stmt);
					int maxCopies = 0, bplan = -9;
					if (results.next()) {
				%>
				<tr>
					<td><%=results.getString("ISBN")%></td>
					<td><%=results.getString("title")%></td>
					<td><%=results.getString("author")%></td>
					<td><%=results.getString("publisher")%></td>
					<td><%=results.getString("publish_year")%></td>
					<td><%=results.getInt("copies")%></td>
					<td><%=results.getDouble("price")%></td>
					<td><%=results.getString("format")%></td>
					<td><%=results.getString("keywords")%></td>
					<td><%=results.getString("subject")%></td>
					<td><%=results.getDouble("rate")%></td>
					<td><%=results.getDouble("trust_rate")%></td>
				</tr>
				<%
					maxCopies = results.getInt("copies");
					bplan = results.getInt("plan");				
					}
				%>
				
			</table>
			<br/>
			<hr/>
			<br/><br/>
			<%if(ptype>=bplan){ %>
			<div class="col-4">
			<p>Congratulations this book is available in your plan!! You can read it online.</p>
			</div>
			<div class="col-10">
			<a href="#"><button type="submit">Open</button></a>
			</div>
			<br/><br/><br/><br/><br/><br/><br/><hr>	
		<%} else{%>
			<div class="col-1">
			<p>Sorry!! This book is not available in you. You can't read it online.</p>
			</div>
			<br/><hr>
			<%} %>				
			<h3>New Order : </h3>
			<form action="orders.jsp" method="post">
				<input type="hidden" name="ISBN" value=<%=ISBN%> />
				<label class="col-4">Copies You Could Order is <%=maxCopies%> : </label>
				<input name="order_copies" class="col-4" id="order_copies" value="0" >
				<button type="submit" id="order_btn" class="col-4">Submit</button><br/>
				<script type="text/javascript">
					$("#order_copies").change(function(e) {
						var oc = Number($("#order_copies").val());
						var limit = <%=maxCopies%>;
						if (oc > limit) {
							$("#order_btn").attr("disabled","disabled");
						} else {
							$("#order_btn").removeAttr("disabled");
						}
					});
				</script>
			</form>
			<br/>
			<hr/>
			<br/>
			<h3>Add a review: </h3>
			<%
				Statement stmt4 = con.con.createStatement();
				Boolean existFB = feedbacks.existEntry(ISBN, name, stmt4);
				if (existFB) {
			%>
				<p>Sorry, You can not review it again!!</p>
			<%
				} else {
			%>
				<form action="onebook.jsp" method="post">
					<input type="hidden" name="ISBN" value=<%="'" + request.getParameter("ISBN") +"'"%> />
					<label class="col-4">Comment : </label>
					<input class="col-4" type="text" name="fb_comment" required="required"/><br/><br/>
					<label class="col-4">Rate : </label>
					<select class="col-4" name="fb_rate">
						<option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
						<option value="9">9</option>
						<option value="10">10</option>
					</select>
					<button class="col-4" type="submit">Submit</button>
				</form>

			<%
				}
			%>	
			<br/><br/><hr><br/><br/>
			<h3>Feedbacks (Order by Useful) : </h3>
			<%
				
				ResultSet resultFeedback = feedbacks.showEntry(ISBN, cid, con.stmt);
				while (resultFeedback.next()) {
			%>
				<table border="1">
					<tr>
						<th>Comment</th>
						<th>Rate</th>
						<th>Date</th>
						<th>Customer</th>
						<th>Trust User</th>
						<th>Useful</th>
					</tr>
					<tr>
						<td><%=resultFeedback.getString("comment")%></td>
						<td><%=resultFeedback.getInt("rate")%></td>
						<td><%=resultFeedback.getString("date")%></td>
						<td><%=resultFeedback.getString("customer")%></td>
						<td><%=resultFeedback.getBoolean("trusted")%></td>
						<td><%=resultFeedback.getDouble("useful")%></td>
					</tr>
				</table>
				<div>
				<%
					int fid = resultFeedback.getInt("fid"),count = 0;
					Statement stmt2 = con.con.createStatement();
					ResultSet resultFR = feedback_rates.showFeedback_Rate(fid, cid, stmt2);
					while (resultFR.next()) {
						if (count == 0) {
				%>
				<h4>Ratings of this Feedback: </h4>
				<table>
					<tr>
						<th>Useful Rate</th>
						<th>Customer</th>
						<th>Trust User</th>
					</tr>				
				<% } count++; %>		
					<tr>
						<td><%=resultFR.getInt("rate")%></td>
						<td><%=resultFR.getString("customer")%></td>
						<td><%=resultFR.getBoolean("trusted")%></td>
					
					</tr>
				<%
					}
				%>
				</table>
				<br/>
				<%
					if (name.equals(resultFeedback.getString("customer"))) {	
				%>
					<p>Sorry, You can not rate YOURSELF !!</p>	

				<% } else { 

					Statement stmt3 = con.con.createStatement();
					Boolean existFR = feedback_rates.existFeedback_Rate(fid, name, stmt3);
					if (existFR) {
				%>
					<p>Sorry, You can not rate it Twice !!</p>
				<%
					} else {
				%>
				
				<form action="onebook.jsp" method="post">
					<label class="col-4">Rate this feedback: </label>					
					<input type="hidden" name="ISBN" value=<%=ISBN%> />
					<input type="hidden" name="fid" value=<%= "'" +fid+ "'"%> />
					<select class="col-1" name="fr_rate">
						<option value="-1">------</option>
						<option value="10">Very Useful</option>
						<option value="5">Useful</option>
						<option value="1">Useless</option>
					</select>
					<button type="submit">Submit</button>
				</form>
				<%
					}
				}
				%>
					
					<br/>
				</div>
				<hr/>
				<br/>
			<%
				}
			%>

			<%
				con.closeConnection();
			%>
		</div>
		<div class="footer">
			<div class="col-2">
				<h4>About US</h4>
				<p>The BookKeepers </p>
				<p>Mail : "example@example.com" </p>
			</div>
			<div class="col-2">
				<h4>About the Site</h4>
				<p>BUILT FOR ALL FUNCTIONALITY !! </p>
			</div>
		</div>
	</div>	
</body>
</html>
