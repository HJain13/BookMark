<%@ page language="java" import="io.github.hjain13.*" %>
<html>
<head>
 	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register | BookMark</title>
	<link rel="stylesheet" href="base.css">
</head>

<body style="background: #eee url('resource/login_bg.png') repeat scroll 0% 0%">
	<%
		io.github.hjain13.Connector con = new Connector();
		io.github.hjain13.Customer customers = new Customer();
		String loginname = (String)request.getParameter("loginname_r");
		Boolean exist = customers.existCustomer(loginname, con.stmt);
		if (exist) {
	%>
	<script type="text/javascript">alert("This Login Name has been used !!");</script>
	<% } else { %>
	<%
		String password = (String)request.getParameter("password_r");
		String fullname = (String)request.getParameter("fullname_r");
		String address = (String)request.getParameter("address_r");
		String phone = (String)request.getParameter("phone_r");
		String[] attrValue = new String[] {loginname, password, fullname, address, phone};
		customers.newCustomer(attrValue, con.stmt);
	%>
	<script type="text/javascript">alert("Register Successful !!");</script>	
	<% } %>
	<% con.closeConnection(); %>
	<script type="text/javascript">location.href = "index.jsp";</script>
</body>
</html>