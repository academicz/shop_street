<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>

<%@ page import="java.util.*"%>

<%

Class.forName("com.mysql.jdbc.Driver");
Connection c=DriverManager.getConnection("jdbc:mysql://localhost:3306/db_spare","root","");
 Statement st=c.createStatement();
status=st.executeQuery("insert into tbl_branch value(NULL,'"+name+"','"+regno+"','"+address+"','"+phone+"','"+mobile+"','"+place+"','"+state+"','"+pin+"')");
 
 Statement st2=c.createStatement();
 ResultSet mid=st2.executeQuery("select max(b_id) as id from tbl_branch");
 
 if(mid.next())
 {
    id=mid.getInt("id");
     out.print(id);
 }
 status=0;
 
 Statement st1=c.createStatement();
 status=st1.executeUpdate("insert into tbl_login value('"+username+"','"+id+"','"+password+"','2')");
if(status==1)
{
    session.setAttribute("message","Branch Added Successfully");
}
else
{
    session.setAttribute("message","Branch not added");
}
response.sendRedirect("add_branch.jsp");
%>