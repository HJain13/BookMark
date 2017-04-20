<!DOCTYPE html>
<%@ page language="java" import="io.github.hjain13.*, java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
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
	<c:forEach items="${cookie}" var="currentCookie">  
		<c:choose>
		    <c:when test="${currentCookie.value.name == 'loginname'}">
				<c:set var="login_Name" scope="session" value="${currentCookie.value.value}"/>
		    </c:when>
		</c:choose>
	</c:forEach>
	<c:choose>
	    <c:when test="${login_Name == ''}">
			<script type="text/javascript">
				alert("For best results Log In !!");			
			</script>			
	    </c:when>
	</c:choose>	
	<% 
		String name = "", name_q = "";
		name = request.getParameter("loginName");
		name_q = "'" + name + "'";
		
		io.github.hjain13.Connector con = new Connector();
		io.github.hjain13.Book books = new Book();
		io.github.hjain13.Customer customers = new Customer();		
		ResultSet results;
		String[] sigmaAttr = { "login_name" }, sigmaValue = { name_q };
		results = customers.showCustomer(sigmaAttr, sigmaValue, con.stmt);
		int cid = 0, ptype = 0, type1 = 0;
		String fullName = "", address = "";
		if (results.next()) {
			cid = results.getInt("cid");
			ptype = results.getInt("plan");
			fullName = results.getString("full_name");
			address = results.getString("address");
			type1 = results.getInt("type");
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
				<c:choose>
				    <c:when test="${login_Name == ''}">
				<a href="#">Welcome, Visitor</a>		
				    </c:when>
				    <c:otherwise>
				<a href="user.jsp">Users</a>				    
					<c:choose>
					    <c:when test="${type >= 1}">
				<a href="bookKeeping.jsp">Book Mgmt</a>	
					    </c:when>
					</c:choose>
					<c:choose>
					    <c:when test="${type == 2}">
				<a href="admin.jsp">User Mgmt</a>	
					    </c:when>
					</c:choose>	
				<a href="profile.jsp">Welcome, <c:out value="${login_name}" /></a>
					</c:otherwise>		    
				</c:choose>
				<a href="orders.jsp"><i class="fa fa-shopping-cart"></i></a>	
				<c:choose>
				    <c:when test="${login_Name == ''}">
				<a id="log-in">Log In</a>&nbsp; 		
				    </c:when>
				    <c:otherwise>
				<a id="logout">Logout</a>&nbsp; 				    
				    </c:otherwise>
				</c:choose>													

			</div>
		</div>
	</nav>
	<script type="text/javascript">
		$("#logout").click(function(e) {
			document.cookie = "loginname=";
			location.href="../index.jsp";
		});
		$("#log-in").click(function(e) {
			location.href="../index.jsp";
		});		
		jQuery(document).ready(function(){
	        jQuery('#hideshow').on('click', function(event) {        
	             jQuery('#tableContent').toggle('show');
	        });
	    });		
	</script>
	
	<div id="main-container" class="top-space">
		<div class="col-1 bottom-space">
			<input type='button' id='hideshow' value='Hide/Show Books'>	
				<div id='tableContent'>		
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
						results = books.browseEntry(emptyQuery, 4, name_q, con.stmt);
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
			</div>
			<h3>Browse Books ( Case Sensitive ): </h3>
			<form class="col-1" action="browsebook.jsp" method="POST">
				<label class="col-10">Type 1 : </label>
				<select class="col-10" name="type1" >
					<option value="author">author</option>	
					<option value="publisher">publisher</option>
					<option value="title">title-word</option>
					<option value="subject">subject</option>
				</select>
				<label class="col-10">Value 1 : </label>
				<input class="col-4" name="value1" type="text">
				<label class="col-4">Conjective 1 and 2 : </label>
				<select class="col-10" name="conj1">
					<option value="and">and</option>
					<option value="or">or</option>
				</select>
				<br/><br/>
				<label class="col-10">Type 2 : </label>
				<select class="col-10" name="type2" >
					<option value="author">author</option>	
					<option value="publisher">publisher</option>
					<option value="title">title-word</option>
					<option value="subject">subject</option>
				</select>
				<label class="col-10">Value 2 : </label>
				<input class="col-4" name="value2" type="text">
				<label class="col-4" >Conjective 2 and 3 : </label>
				<select class="col-10" name="conj2">
					<option value="and">and</option>
					<option value="or">or</option>
				</select>
				<br/><br/>
				<label class="col-10">Type 3 : </label>
				<select class="col-10" name="type3" >
					<option value="author">author</option>	
					<option value="publisher">publisher</option>
					<option value="title">title-word</option>
					<option value="subject">subject</option>
				</select>
				<label class="col-10">Value 3 : </label>
				<input class="col-4" name="value3" type="text">
				<label class="col-4" >Conjective 3 and 4 : </label>
				<select class="col-10" name="conj3">
					<option value="and">and</option>
					<option value="or">or</option>
				</select>
				<br/><br/>
				<label class="col-10">Type 4: </label>
				<select class="col-10" name="type4" >
					<option value="author">author</option>	
					<option value="publisher">publisher</option>
					<option value="title">title-word</option>
					<option value="subject">subject</option>
				</select>
				<label class="col-10">Value 4 : </label>
				<input class="col-4" name="value4" type="text">
				<label class="col-4" >Conjective 4 and 5: </label>
				<select class="col-10" name="conj4">
					<option value="and">and</option>
					<option value="or">or</option>
				</select>
				<br/><br/>
				<label class="col-10">Sort By : </label>
				<select class="col-4" name="sort" >
					<option value="0">Don't sort</option>
					<option value="1">Year</option>
					<option value="2">Avg Numerical Scores of Feedbacks</option>
					<option value="3">Avg Numerical Scores of TRUSTED Users' Feedbacks</option>
				</select>
				<button style="margin-left:20px;" class="button-primary" type="submit">Submit</button>
			</form>
			<br/><br/><br/><br/><br/><br/>			
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
						results = books.browseEntry(query, sort, name_q, con.stmt);
						int flag = 0;
						while (results.next()) {
						if (flag == 0) {
				%>
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
				<% } flag++; %>			
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