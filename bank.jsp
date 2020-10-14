<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>

<%@ page import="java.util.*"%>
<% if(session.getAttribute("user")==null)
{
    response.sendRedirect("login.jsp");
}
%>
<% Class.forName("com.mysql.jdbc.Driver");
Connection c=DriverManager.getConnection("jdbc:mysql://localhost:3306/db_spare","root","");
session.setAttribute("success",null); %>
<!doctype html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0 minimal-ui"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<meta name="apple-mobile-web-app-capable" content="yes"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<meta http-equiv="cache-control" content="max-age=0" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
<meta http-equiv="pragma" content="no-cache" />

<title>BillDesk - All Your Payments. Single Location</title>
<link href="css/bank.css" rel="stylesheet" type="text/css"/>


</head>


<body>

<div id="mainContainer" class="row large-centered">

  <div class="text-center"><h2>BANK</h2></div>
  
  <hr class="divider">
  <dl class="mercDetails">
  	<dt>Merchant</dt> 				<dd>Shop Street</dd>
    <dt>Transaction Amount</dt> 	<dd>INR <% Statement stc1=c.createStatement();
    ResultSet cr1=stc1.executeQuery("select sum(discount),sum(amount)-sum(discount) as total from tbl_cart where user_id='"+session.getAttribute("user")+"'");
      if(cr1.next())
      {
      out.print(cr1.getInt("total"));}
      %></dd>
    <dt>Debit Card</dt> 		<dd>xxxx xxxx xxxx <% String no=request.getParameter("number"); out.print(no.substring(no.length() - 4));%></%></dd>
  </dl>
  <hr class="divider">
  
  
<form name="form1" id="form1" method="post" action="complete_payment.jsp">
<fieldset class="page2">
<div class="page-heading">
<h6 class="form-heading">Authenticate Payment</h6>
<p class="form-subheading">OTP sent to your mobile number ending <strong>0119</strong></p>


</div>

<div class="row formInputSection">
<div class="large-7 columns">
<label>
  Enter One Time Password (OTP)
  <input type="tel" name="otp"  class="form-control optPass" value="" maxlength="6" autocomplete="off"/>
</label>
</div>
<div class="large-5 columns">
<label>&nbsp;</label><button class="expanded button next" onClick="ValidateForm()">Make Payment</button>
</div>
</div>
<div class="text-right resendBtn requestOTP"><a class="request-link" href="javascript:void(0)">Resend OTP</a></div>
<p>


<a class="tryAgain" href="complete_order.jsp">Go back</a> to merchant
</p>
</fieldset>

<input type="hidden" name="branch" value="<% out.print(request.getParameter("branch")); %>">

</form>
</div>
<script src="bank/script/jquery-1.9.1.js"></script>
<script>
document.onmousedown = rightclickD; function rightclickD(e) { e = e||event; if (e.button == 2) { alert('Function Disabled...'); return false; } }
function ValidateForm() { 
	var regPin = RegExp("^[0-9]{4,6}$");
	if( document.form1.customerpin.value == "" || !document.form1.customerpin.value.match(regPin) ) {	 
		alert("Please enter a valid 6 digit One Time Password (OTP) receive on your registered Mobile Number."); document.form1.customerpin.focus(); return false;  
	}
    else
        {
            document.form1.submit();
        }

}
</script>

</body>
</html>