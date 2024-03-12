<%@ page import="java.sql.*" %>
<%@ page import="com.twilio.Twilio" %>
<%@ page import="com.twilio.rest.api.v2010.account.Message" %>
<%@ page import="com.twilio.type.PhoneNumber" %>
<%
String name=(String)session.getAttribute("user");  
    String old_password = request.getParameter("old_password");
    String new_password = request.getParameter("new_password");
    if(old_password!=new_password){
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
                   if(user.equals(name) && password.equals(old_password)) {
                         flag=1;
                            PreparedStatement preparedStatement = con.prepareStatement("UPDATE User_registration SET password = ? WHERE Account_number = ?");
                            preparedStatement.setString(1, new_password);
                            preparedStatement.setString(2, user);

                            int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    // Registration successful, send SMS using Twilio
                    String ACCOUNT_SID = "ACf60346bb7de97cdfa966086a5a9936b7";
                    String AUTH_TOKEN = "c2b773c3771ff8e91eb6de7df8c6384c";
                    String TWILIO_NUMBER = "+17209034894";
                    String recipientNumber = "+916301457870"; // Replace with the actual recipient's phone number

                    Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

                    String messageBody = "Your SDK City Bank account password changed successfully.\nAccount Number: " + name + "\nNew Password: " + new_password;

                    Message message = Message.creator(
                            new PhoneNumber(recipientNumber),
                            new PhoneNumber(TWILIO_NUMBER),
                            messageBody)
                            .create();

                    // Display success message and redirect
                    out.print("<script>alert('successfully Changed. SMS sent with new account details');</script>");
                   
                } else {
                    // Registration failed
                    out.print("<script>alert('failed to change');</script>");
        
                }
                   }
              }
              if(flag==1){
                    out.print("<script>window.history.back();</script>");
              }
              else{
                  out.print("<script>alert('Invalid old password');</script>");
                 
              }
             }catch(Exception e){
                out.print(e);
             }
    }
    else{
         out.print("<script>alert('Both Old and New are same');</script>");
        
    }
   
%>
