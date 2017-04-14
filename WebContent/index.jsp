<!DOCTYPE html>
<%@ page language="java" import="io.github.hjain13.*, java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="en">
<head>
 	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>BookMark | Online Book Store</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="./slick/slick.css">
	<link rel="stylesheet" type="text/css" href="./slick/slick-theme.css">    
	<link rel="stylesheet" href="base.css">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="resources/js/float-panel.js"></script>	
</head>

<% 
	io.github.hjain13.Connector con = new Connector();
	io.github.hjain13.Book books = new Book();
	io.github.hjain13.Customer customers = new Customer();
	io.github.hjain13.Common com = new Common();
%>

<script type="text/javascript">
	function getCookie(cName) {
		var cStart, cEnd;
		if (document.cookie.length > 0) {
			cStart = document.cookie.indexOf(cName+"=");
			if (cStart != -1) {
				cStart = cStart + cName.length + 1;
				cEnd = document.cookie.indexOf(";", cStart);
				if (cEnd == -1) cEnd=document.cookie.length;
				return unescape(document.cookie.substring(cStart, cEnd));
			}
		}
		return "";
	}
	function checkCookie() {
		var username = getCookie('loginname');
		if (username != null && username != "") {
			location.href = "login.jsp";
		}
	}
</script>


<body onLoad="checkCookie()">
	<nav>
		<div class="float-panel" data-top="0" data-scroll="500">
			<div style="text-align:right;max-width:1360px;margin:0 auto;">
				<a href="#" style="float:left;">
					<i class="fa f fa-bookmark-o"></i>&nbsp;
					<em style="font:bold 20px Segoe UI;letter-spacing:1px;">BookMark</em>
				</a>
				<a href="#"><i class="fa fa-search"></i>Browse Books</a>
				<a href="#">Login</a>
				<a href="#"></a>
			</div>
		</div>
	</nav>
	<section class="autoplay slider">
		<div>
			<a href="#"><img src="http://placehold.it/1800x800?text=1"></a>
		</div>
		<div>
			<a href="#"><img src="http://placehold.it/1800x800?text=2"></a>
		</div>
		<div>
			<a href="#"><img src="http://placehold.it/1800x800?text=3"></a>
		</div>
		<div>
			<a href="#"><img src="http://placehold.it/1800x800?text=4"></a>
		</div>
		<div>
			<a href="#"><img src="http://placehold.it/1800x800?text=5"></a>
		</div>
		<div>
			<a href="#"><img src="http://placehold.it/1800x800?text=6"></a>
		</div>
	</section>
	<div id="main-container" class="top-space">
		<div class="col-1">
			<div id="sidebar">
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
					%>
				</ul>
			</div>
			<!-- End Sidebar -->
			<!-- Content -->
			<div id="content">
			<!-- Products -->
				<h3>Buying Suggestions</h3>
				<ul id="rig" class="top-space">
					<%
						//out.println(cid);
						ResultSet results = com.suggestVisitor(con.stmt);
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
							String img_href = "'resources/images/image0" + count + ".jpg'";
							
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
							String img_href0 = "'resources/images/image0" + count + ".jpg'";
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
				<div class="cl">&nbsp;</div>
				<!-- Best-sellers -->
				<div id="best-sellers">
					<h3>Top Popular Books (Cover Random. lol)</h3>
					<ul>
						<%
							count = 0;
							results = com.mostPopular("ISBN", "8", con.stmt);
							while (results.next()) {

								count++;
								String ISBN = results.getString("ISBN");
								String popularHref = "'onebook.jsp?ISBN=" + ISBN + "'"; 
								String img_href = "'resources/images/image0" + count + ".jpg'";
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
							<li>
								<div class="product">
								<a href=<%=popularHref%>>
									<img src=<%=img_href%> alt="" />
									<span class="book-name"><%=bookName%> </span>
									<span class="author"><%=author%></span>
									<span class="price"><span class="low">$</span><%=price%><span class="high">00</span></span>
								</a>
							</li>
						<%
							}
							con.closeConnection();
						%>
					</ul>
				</div>
				<!-- End Best-sellers -->
			</div>
		</div>
		<div class="footer">

		</div>
	</div>

		<!-- End Content -->	
<!--    <div class="container">
	   <div class="login-container">
			<div id="output"></div>
			<div class="avatar"></div>
			<div class="form-box">
				<form id="form_login" action="login.jsp" method="POST">
					<input name="loginname" type="text" placeholder="Login Name">
					<input name="password" type="password" placeholder="Password">
					<button id="btn_login" class="btn btn-info btn-block login" type="submit" onclick="return checkLogin()">Login</button>
					<button id="btn_register" class="btn btn-info btn-block login" type="submit">Register</button>
				</form>
				<form id="form_init" action="init.jsp" method="POST">
					<button id="btn_init" class="btn btn-info btn-block login" type="submit"> Init Database</button>
				</form>
				<form id="form_register" action="register.jsp" method="POST">
					<input name="loginname_r" type="text" placeholder="Login Name">
					<input name="password_r" type="text" placeholder="Password">
					<input name="fullname_r" type="text" placeholder="Full Name">
					<input name="address_r" type="text" placeholder="Address">
					<input name="phone_r" type="text" placeholder="Phone Num">
					<button id="btn_confirm" class="btn btn-info btn-block login" type="submit" onclick="return checkRegister()">Confirm</button>
					<button id="btn_cancel" class="btn btn-info btn-block login" type="submit">Cancel</button>
				</form>
				<br/>
				<label>Admin username : root</label>
				<label>Admin password : root</label>
				<br/>
				<label>Client username : feifei</label>
				<label>Client password : great</label>
			</div>
		</div>       
	</div>
	<script src="./js/login.js" type="text/javascript"></script>
-->
	<script src="./slick/slick.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		$('.autoplay').slick({
			dots: true,
			infinite: true,				
			slidesToShow: 1,
			slidesToScroll: 1,
			autoplay: true,
			autoplaySpeed: 2000,
		});	
	</script>
</body>
</html>
