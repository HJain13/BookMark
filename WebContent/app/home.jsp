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
				alert("Please Login First !!");
				location.href="../index.jsp";
			</script>
	    </c:when>
	</c:choose>	

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
				<a href="profile.jsp">Welcome, <c:out value="${sessionScope.fullName}" /></a>
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
	<!-- End Header -->
	<div id="main-container">
		<section class="autoplay slider">
			<div>
				<a href="#"><img src="../resources/images/slider1.jpg"></a>
			</div>
			<div>
				<a href="#"><img src="../resources/images/slider2.jpg"></a>
			</div>
			<div>
				<a href="#"><img src="../resources/images/slider3.jpg"></a>
			</div>
			<div>
				<a href="#"><img src="../resources/images/slider4.jpg"></a>
			</div>
			<div>
				<a href="#"><img src="../resources/images/slider5.jpg"></a>
			</div>
			<div>
				<a href="#"><img src="http://placehold.it/1800x800?text=6"></a>
			</div>
		</section>
		<div class="col-1">
			<!-- Content -->
			<%	
			io.github.hjain13.Connector con = new Connector();
			io.github.hjain13.Book books = new Book();
			io.github.hjain13.Customer customers = new Customer();
			io.github.hjain13.Common com = new Common();
		
			ResultSet results;		
			int cid = 0, ptype = 0, type = 0;
			String fullName = "", address = "";	
			%>			
				<div id="content">
				<!-- Products -->
					<h3>Buying Suggestions</h3>
					<ul id="rig" class="top-space">
						<%
							results = com.suggestVisitor(con.stmt);
							int count = 0;
							while (results.next()) {
								count++;
								if (count >= 9) break;
								String ISBN = results.getString("ISBN");
								String href = "'onebook.jsp?ISBN=" + ISBN + "'"; 
								int len = 30;
								String bookName = results.getString("title");
								if (len > bookName.length()) len = bookName.length();
								bookName = bookName.substring(0, len);
								len = 15;
								String author = results.getString("author");
								if (len > author.length()) len = author.length();
								author = author.substring(0, len);
								String d = results.getDouble("price") + "";
								int price = Integer.valueOf(d.substring(0, d.indexOf('.')));
								//String img_href = "'resources/images/book_" + ISBN + ".jpg'";
								String img_href = "'../resources/images/image0" + count + ".jpg'";
								
						%>
						<li class="slideanim">
							<a class="info rig-cell" href=<%=href%> >
								<span class="holder">
									<img src=<%=img_href%> alt="" />
									<span class="book-name"><%=bookName%></span>
									<span class="author"><%=author%></span>
									<span class="description">Some descriptions. <br />More descriptions.</span>
								</span>
							</a>
							<a href=<%=href%> class="buy-btn">BUY NOW <span class="price"><span class="low">$</span><%=price%><span class="high">00</span></span></a>
						</li>
						<%
							}
	
							for (count=count + 1; count <= 8; count++) {
								String img_href0 = "'../resources/images/image0" + count + ".jpg'";
						%>
						<li>
							<div class="product">
								<a href="browsebook.jsp" class="info">
									<span class="holder">
										<img src=<%=img_href0%> alt="" />
										<span class="book-name">Jump to All Books</span>
										<span class="author">Author</span>
										<span class="description">A description.<br />More descriptions. <br />Many descriptions.</span>
									</span>
								</a>
								<a href="browsebook.jsp" class="buy-btn">BUY NOW <span class="price"><span class="low">$</span>40<span class="high">00</span></span></a>
							</div>
						</li>
						<%
							}
						%>
					</ul>
				<!-- End Products -->
					<!-- Best-sellers -->
					<div id="best-sellers">
						<h3>Top Popular Books</h3>
						<section class="regular slider" style="padding: 0 0">
							<%
								count = 0;
								results = com.mostPopular("ISBN", "8", con.stmt);
								while (results.next()) {
	
									count++;
									String ISBN = results.getString("ISBN");
									String popularHref = "'onebook.jsp?ISBN=" + ISBN + "'"; 
									String img_href = "'../resources/images/image0" + count + ".jpg'";
									int len = 15;
									String bookName = results.getString("title");
									if (len > bookName.length()) len = bookName.length();
									bookName = bookName.substring(0, len);
									len = 15;
									String author = results.getString("author");
									if (len > author.length()) len = author.length();
									author = author.substring(0, len);
									String d= results.getDouble("price") + "";
									int price = Integer.valueOf(d.substring(0, d.indexOf('.')));
									
							%>
								<div style="padding: 80px">
									<a href=<%=popularHref%>>
										<img width="100px" src=<%=img_href%> alt="" />
										<span class="book-name"><%=bookName%> </span>
										<span class="author"><%=author%></span>
										<span class="price"><span class="low">$</span><%=price%><span class="high">00</span></span>
									</a>
								</div>
							<%
								}
							%>
						</section>
					</div>
					<!-- End Best-sellers -->
				<div class="top-space bottom-space">
					<h4>Top Popular Authors</h4>
					<ul>
						<%
							ResultSet popularResult = com.mostPopularAuthor("10", con.stmt);
							while (popularResult.next()) {
						%>
							<li><%=popularResult.getString("author")%></li>
						<%
							}
						%>
					</ul>
					<h4 class="top-space">Top Popular Publishers</h4>
					<ul>
						<%
							popularResult = com.mostPopular("publisher", "10", con.stmt);
							while (popularResult.next()) {
						%>
							<li><%=popularResult.getString("publisher")%></li>
						<%
							}
							con.closeConnection();					
						%>
					</ul>
				</div>				
			</div>
		</div>
	</div>
	<div class="footer">
		<div class="col-2">
			<h4>About US</h4>
			<p>The BookKeepers </p>
			<p>Mail : "example@example.com" </p>
		</div>
		<div class="col-2">
			<h4>About this Site</h4>
			<p>BUILT FOR ALL FUNCTIONALITY !! </p>
		</div>
	</div>	
	<script src="../slick/slick.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		$('.autoplay').slick({
			dots: true,
			infinite: true,				
			slidesToShow: 1,
			slidesToScroll: 1,
			autoplay: true,
			autoplaySpeed: 2000,
		});	
		$('.regular').slick({
			dots: true,
			infinite: true,				
			slidesToShow: 4,
			slidesToScroll: 2,
		});			
	</script>	
</body>
</html>