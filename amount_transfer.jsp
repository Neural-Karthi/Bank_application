<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.concurrent.ThreadLocalRandom" %>
<%@ page import="com.twilio.Twilio" %>
<%@ page import="com.twilio.rest.api.v2010.account.Message" %>
<%@ page import="com.twilio.type.PhoneNumber" %>

<%@ page import="java.sql.*" %>
<%
String name=(String)session.getAttribute("user");  
%>
<!DOCTYPE html>
<html lang="en">
   <head><title>
        </title>
        <link rel="stylesheet" href="CSS/payment_style.css">
        <link rel="stylesheet" href="CSS/hotel_style.css">
        <link rel="stylesheet" type="text/css" href="CSS/headstyle.css">
        <link rel="stylesheet" type="text/css" href="CSS/swal_alert.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
   </head>
   <body>
    <center>
        <fieldset class="fieldset_2" style="width:80vw;height:33.5vw;margin-top:1.75vw">
            <h1 class="payment_title">OTP CONFIRMATION</h1>
            <div style="background-color: rgb(238, 238, 238);width: 35vw;height: 20vw;border-radius: .5vw;">
                <br>
                <br>
                <br>
                <br>
                <p>Note - OTP send to Your Mobile number</p>
                <form id="otpForm" action="otp_verification.jsp" method="post">
                    <div>
                        <table >
 <tr >
                                <td><h3 style="font-family:josefin sans semibold;">Enter OTP - </h3></td>
                                 <td><input type="text" name="user_otp" class="input" style="width:10vw"/></td>
                                 
<%
    String from_acc_number = (String) session.getAttribute("user");
    String to_acc_number = request.getParameter("to_acc_number");
    String amount = request.getParameter("amount");
    String Remarks = request.getParameter("Remarks");
    String driver = "com.mysql.jdbc.Driver";
    try {
         Class.forName(driver);
         Connection con = DriverManager.getConnection("jdbc:mysql://localhost/SDK_bank", "root", "19BCS0090");
         Statement s = con.createStatement();
         ResultSet rs = s.executeQuery("SELECT account_number FROM account_details");

        int count = 0;
        while (rs.next()) {
            String user = rs.getString("account_number");
            if (user.equals(from_acc_number)) {
                count++; 
            }
            if (user.equals(to_acc_number)) {
                count++;
            }
        }

        if (count == 2) {
             Random random = new Random();
             int nu = ThreadLocalRandom.current().nextInt(1000000);
             String otp = Integer.toString(nu);
                    String ACCOUNT_SID = "ACf60346bb7de97cdfa966086a5a9936b7";
                    String AUTH_TOKEN = "c2b773c3771ff8e91eb6de7df8c6384c";
                    String TWILIO_NUMBER = "+17209034894";
                    String recipientNumber = "+916301457870";
                    Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
                    String messageBody = "We have send a OTP for transfer the amount :" + otp;
                    Message message = Message.creator(
                            new PhoneNumber(recipientNumber),
                            new PhoneNumber(TWILIO_NUMBER),
                            messageBody)
                            .create();
                  out.print("<td><input type=\"hidden\" name=\"amount\" value=\"" + amount + "\"></td><td><input type=\"hidden\" name=\"to_acc_number\" value=\"" + to_acc_number + "\"></td><td><input type=\"hidden\" name=\"from_acc_number\" value=\"" + from_acc_number + "\"></td><td><input type=\"hidden\" name=\"generatedOTP\" value=\"" + otp + "\"></td>");
        } else {
             out.print("<script>alert('Sorry from account not belongs to our Bank');</script>");
             out.print("<script>window.history.back();</script>");
        }
        
        con.close(); // Close the database connection
    } catch (Exception e) {
        out.print(e);
    }
%>                      
                            </tr>
                        </table>
                        <table style="margin-top: -1.4vw;margin-left: 5.2vw;">
                            <tr>
                                <td><button type="button" class="check_out" name="cancel" id="cancel" style="margin-top: 2vw;width:5vw;background-color: red;height:2.4vw" onclick="back()">Cancel</button></td>
                                <td><button type="submit" class="check_out" name="submit" id="submit" style="margin-top: 2vw;width:5vw;height: 2.4vw;">Done</button></td>
                            </tr>
                        </table>

                    </div>
                   
                </form>
            </div>
        </fieldset>
    </center>
</body>
<script>
    function back(){
        window.parent.location.href='Home.html';
    }
    document.getElementById('cancel').addEventListener('click', function(event) {
        event.preventDefault(); 
        back(); 
    });
</script>

</html>