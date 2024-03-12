<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("Account_Number");
    String userPassword = request.getParameter("Password");
    String driver = "com.mysql.jdbc.Driver";
    try {
    Class.forName(driver);
     Connection con = DriverManager.getConnection("jdbc:mysql://localhost/SDK_bank", "root", "19BCS0090");
     Statement s = con.createStatement();
     ResultSet rs = s.executeQuery("SELECT Account_number, password FROM User_registration");
     int flag=0;
     while(rs.next()){
          String user=rs.getString("Account_number");
          String password=rs.getString("password");
          if(user.equals(username) && password.equals(userPassword)) {
                flag=1;
                session.setAttribute("user",username);
          }
     }
     if(flag==1){
           out.print("<script>alert('successfully');</script>");
           out.print("<script>window.location.href='Home.html';</script>");
     }
     else{
         out.print("<script>alert('Invalid username or password');</script>");
         out.print("<script>window.history.back();</script>");
     }
    }catch(Exception e){
       out.print(e);
    }
%>

