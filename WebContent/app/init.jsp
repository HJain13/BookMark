<%@ page language="java" import="io.github.hjain13.*" %>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title> Init Database | BookMark </title>
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css" id="bootstrap-css" />
    <link rel="stylesheet" type="text/css" href="./css/login.css" />
    <script src="./js/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="./js/bootstrap.min.js" type="text/javascript"></script>
</head>

<body style="background: #eee url('resource/login_bg.png') repeat scroll 0% 0%">
	<%
		io.github.hjain13.Connector con = new Connector();
		io.github.hjain13.Common com = new Common();
		com.initTable(con.stmt);
	%>
	<script type="text/javascript">
		alert(" Initialize Database Successful !! Back to Login Page. ");
		document.cookie = "loginname=";
   		location.href="../index.jsp";
	</script>
</body>
</html>