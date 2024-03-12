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
                <table class="table_1">
                <tr>
                   <td><h1 class="payment_title" style="margin-left:-23vw">MY ACCOUNT - <%=name%></h1></td>
                </tr>
             </table>
             <hr>
             <div  style="display:flex">
                  <div class="payment_selection">
                     <button class="button_1" id="button_1" onclick="debit_Card()">
                         <table class="">
                           <tr>
                               <td><h3 class="debit_card_text">Profile</h3></td>
                           </tr>
                         </table>
                     </button>
                        <button class="button_2" id="button_2" onclick="upi()">
                         <table class="">
                           <tr>
                               <td><h3 class="debit_card_text">Change password</h3></td>
                           </tr>
                         </table>
                     </button>
                   
                  </div>
                 <div class="payment_view">
                       <div id="debit_card_details" >
                       <form method="POST" action="">
                         <table class="payment_card_details" style="margin-top:3vw">   
 <%
 String driver = "com.mysql.jdbc.Driver";
    try {
    Class.forName(driver);
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/SDK_bank", "root", "19BCS0090");
    Statement s = con.createStatement();
    ResultSet rs = s.executeQuery("SELECT Account_number,Firstname,Lastname,Fathername,Aadhar_number,Pancard,Address,Pincode,State,Email_ID,dob,phonenumber FROM User_registration");
    int flag = 0;
    while (rs.next()) {
        String user = rs.getString("account_number");
        if (user.equals(name)) {
           flag = 1;
            out.println("<tr><td colspan=\"2\">" +
                            "<label style=\"margin-left:23.9vw;margin-top:-2vw\">First name</label>" +
                               "<input type=\"text\" name=\"firstname\" id=\"firstname\" class=\"input\" value=\"" + rs.getString("Firstname") + "\" required style=\"margin-top:1vw\" disabled>" +
                        "</td>");
            out.println("  <td>" +
                            "<label style=\"margin-left:43.9vw;margin-top:-2vw\">Last name</label>" +
                               "<input type=\"text\" name=\"Lastname\" id=\"Lastname\" class=\"input\" value=\"" + rs.getString("Lastname") + "\" required style=\"margin-top:1vw\" disabled>" +
                         "</td>");
            out.println("  <td colspan=\"2\">" +
                            "<label style=\"margin-left:64vw;margin-top:-2vw\">Date of Birth</label>" +
                             "<input type=\"text\" name=\"DOB\" id=\"DOB\" class=\"input\" value=\"" + rs.getString("dob") + "\" required style=\"margin-top:1vw\"  disabled>" +
                             "</td></tr>");

out.println("  <tr><td colspan=\"2\">" +
    "<label style=\"margin-left:23.9vw;margin-top:2.75vw\">Father Name</label>" +
    "<input type=\"text\" name=\"DOB\" id=\"DOB\" class=\"input\" value=\"" + rs.getString("Fathername") + "\" required style=\"margin-top:1.7vw\"  disabled>" +
"</td>");
out.println("  <td>" +
    "<label style=\"margin-left:43.9vw;margin-top:2.75vw\">Aadhar Number</label>" +
    "<input type=\"text\" name=\"Phone_number\" id=\"Phone_number\" class=\"input\" value=\"" + rs.getString("Aadhar_number") + "\" required style=\"margin-top:1.7vw\" disabled>" +
"</td>");


out.println("  <td>" +
    "<label style=\"margin-left:64vw;margin-top:2.75vw\">Pan Card</label>" +
    "<input type=\"text\" name=\"Phone_number\" id=\"Phone_number\" class=\"input\" value=\"" + rs.getString("Pancard") + "\" required style=\"margin-top:1.7vw\" disabled>" +
"</td></tr>");
out.println(" <tr><td colspan=\"2\">" +
    "<label style=\"margin-left:23.9vw;margin-top:7.2vw\">Address</label>" +
    "<input type=\"text\" name=\"Address\" id=\"Address\" class=\"input\" value=\"" + rs.getString("Address") + "\" required style=\"margin-top:1.7vw\" disabled>" +
"</td>");
out.println(" <td>" +
    "<label style=\"margin-left:43.9vw;margin-top:7.2vw\">Pincode</label>" +
    "<input type=\"text\" name=\"Pincode\" id=\"Pincode\" class=\"input\" value=\"" + rs.getString("Pincode") + "\" required style=\"margin-top:1.7vw\" disabled>" +
"</td>");
out.println(" <td>" +
    "<label style=\"margin-left:64vw;margin-top:7.2vw\">State</label>" +
    "<input type=\"text\" name=\"Pincode\" id=\"Pincode\" class=\"input\" value=\"" + rs.getString("State") + "\" required style=\"margin-top:1.7vw\" disabled>" +
"</td></tr>");

out.println("<tr><td colspan=\"2\">" +
    "<label style=\"margin-left:23.9vw;margin-top:11.5vw\">Phone Number</label>" +
    "<input type=\"text\" name=\"phonenumber\" id=\"phonenumber\" class=\"input\" value=\"" + rs.getString("phonenumber") + "\" required disabled style=\"margin-top:1.6vw\">" +
"</td>");
out.println(" <td>" +
    "<label style=\"margin-left:43.9vw;margin-top:11.5vw\">Password</label>" +
    "<input type=\"text\" name=\"Email_ID\" id=\"Email_ID\" class=\"input\" value=\"" + rs.getString("Email_ID") + "\" required disabled style=\"margin-top:1.6vw\">" +
"</td></tr>");
        }
    }
    if (flag == 0) {
        // User not found
        out.println("User not found");
    }
    con.close(); // Close the connection
} catch (Exception e) {
    out.print(e); // Print any exceptions that occur
}
 %>                       
                                
                            <tr>
                              <td colspan="3">
                                 <h4 style="color:red">Note : Please visit home branch for changes</h4>
                              </td>
                           </tr>
                           </form>
                         </table>
                        
                       </div>
                        
                    <div id="UPI_details">
                     <table class="payment_card_details" style="margin-top:4vw">
                     <form method="POST" action="password_charage.jsp">
                       <tr>
                          <td>
                             <div class="upi_outer">
                                <h2 class="upi_title"></h2>
                             </div>
                          </td>
                       </tr>
                       <tr>
                            <td>
                              <div class="group" id="group_input">      
                                  <input type="text" name="old_password" id="old_password" class="input" >
                                  <label>Enter Current</label>
                              </div>
                            </td>                                           
                       </tr>
                       <tr>
                           <td>
                              <div class="group" id="group_input">      
                                  <input type="text" name="new_password" id="new_password" class="input" >
                                  <label>Enter New Password</label>
                              </div>
                           </td>                                           
                       </tr>
                        <tr>
                          <td>
                               <button class="check_out" name="button3" id="button_upi" >Change</button>
                          </td>
                       </tr>
                       </form>
                     </table>
                       </div> 
                  </div>
             </div></fieldset>
                </center>
        </body>
        <script>
      
        function debit_Card(){
          document.getElementById("debit_card_details").style.display = "block";
          document.getElementById("button_1").style.background = "white";
          document.getElementById("button_1").style.color= "black";
          document.getElementById("button_2").style.background = "#edf1f7";
          document.getElementById("button_2").style.color= "rgb(107, 107, 107)";
          document.getElementById("UPI_details").style.display = "none";
         }
         function upi(){
          document.getElementById("debit_card_details").style.display = "none";
          document.getElementById("button_1").style.background = "#edf1f7";
          document.getElementById("button_1").style.color= "rgb(107, 107, 107)";
          document.getElementById("button_2").style.color= "black";
          document.getElementById("button_2").style.background = "white";
          document.getElementById("UPI_details").style.display = "block";
         }
        </script>
    </html>