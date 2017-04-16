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
		io.github.hjain13.Book books = new Book();
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
			<h3>All Books ( Just for Testing Browsing ): </h3>
			<table border="1">
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
					String emptyQuery = "";
					ResultSet results = books.browseBook(emptyQuery, 4, name_q, con.stmt);
					while (results.next()) {
				%>
				<tr>
					<%
						String ISBN = results.getString("ISBN");
						String href = "'onebook.jsp?ISBN=" + ISBN + "'";
					%>
					<td><a target="_blank" href=<%=href%> ><%=ISBN%></a></td>
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
					}
				%>
				
			</table>
			<br/><br/>
			<h3>Browse Books ( Case Sensitive ): </h3>
			<form action="browsebook.jsp" method="POST">
				<label>Type 1 : </label>
				<select name="type1" >
					<option value="author">author</option>	
					<option value="publisher">publisher</option>
					<option value="title">title-word</option>
					<option value="subject">subject</option>
				</select>
				<label>Value 1 : </label>
				<input name="value1" type="text">
				<br/>
				<label>Conjective 1 and 2 : </label>
				<select name="conj1">
					<option value="and">and</option>
					<option value="or">or</option>
				</select>
				<br/>
				<label>Type 2 : </label>
				<select name="type2" >
					<option value="author">author</option>	
					<option value="publisher">publisher</option>
					<option value="title">title-word</option>
					<option value="subject">subject</option>
				</select>
				<label>Value 2 : </label>
				<input name="value2" type="text">
				<br/>
				<label>Conjective 2 and 3 : </label>
				<select name="conj2">
					<option value="and">and</option>
					<option value="or">or</option>
				</select>
				<br/>
				<label>Type 3 : </label>
				<select name="type3" >
					<option value="author">author</option>	
					<option value="publisher">publisher</option>
					<option value="title">title-word</option>
					<option value="subject">subject</option>
				</select>
				<label>Value 3 : </label>
				<input name="value3" type="text">
				<br/>
				<label>Conjective 3 and 4 : </label>
				<select name="conj3">
					<option value="and">and</option>
					<option value="or">or</option>
				</select>
				<br/>
				<label>Type 4 : </label>
				<select name="type4" >
					<option value="author">author</option>	
					<option value="publisher">publisher</option>
					<option value="title">title-word</option>
					<option value="subject">subject</option>
				</select>
				<label>Value 4 : </label>
				<input name="value4" type="text">
				<br/><br/>
				<label>Sort By : </label>
				<select name="sort" >
					<option value="0">Don't sort</option>
					<option value="1">Year</option>
					<option value="2">Avg Numerical Scores of Feedbacks</option>
					<option value="3">Avg Numerical Scores of TRUSTED Users' Feedbacks</option>
				</select>
				<button type="submit">Submit</button>
			</form>
			<br/>
			<br/>
			<h3>Results of Search</h3>
			<table border="1">
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
					String query = "";
					String value, type, conj;
					value = (String)request.getParameter("value1");
					type = (String)request.getParameter("type1");
					if (value != null && !value.equals("")) {
						query += type + " like " + "'%" + value + "%'";
										
						value = (String)request.getParameter("value2");
						type = (String)request.getParameter("type2");
						if (value != null && !value.equals("")) {
							conj = (String)request.getParameter("conj1");
							query += conj + " ";
							query += type + " like " + "'%" + value + "%'";
						
							value = (String)request.getParameter("value3");
							type = (String)request.getParameter("type3");
							if (value != null && !value.equals("")) {
								conj = (String)request.getParameter("conj2");
								query += conj + " ";
								query += type + " like " + "'%" + value + "%'";
							
								value = (String)request.getParameter("value4");
								type = (String)request.getParameter("type4");
								if (value != null && !value.equals("")) {
									conj = (String)request.getParameter("conj3");
									query += conj + " ";
									query += type + " like " + "'%" + value + "%'";
								}
							}
						}
	
						out.println(query);
						int sort = Integer.valueOf((String)request.getParameter("sort"));
						results = books.browseBook(query, sort, name_q, con.stmt);
						while (results.next()) {
				%>
					<tr>
						<%
							String ISBN = results.getString("ISBN");
							String href = "'onebook.jsp?ISBN=" + ISBN + "'";
						%>
						<td><a target="_blank" href=<%=href%>><%=ISBN%></a></td>
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
						}
					}
				%>
				
			</table>
		</div>
	</div>
			<%
				con.closeConnection();
			%>	
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