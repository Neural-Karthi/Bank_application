<%@ page import="java.sql.*" %>
 <!DOCTYPE html>
          <html lang="en">
             <head><title>
                  Statement</title>
                  <link rel="stylesheet" href="CSS/payment_style.css">
                  <link rel="stylesheet" href="CSS/hotel_style.css">
                  <link rel="stylesheet" href="CSS/order.css">
                  <link rel="stylesheet" type="text/css" href="CSS/headstyle.css">
                  <link rel="stylesheet" type="text/css" href="CSS/swal_alert.css">
                  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
             </head>
                <center>
                         <fieldset class="fieldset_1" style="margin-top:2vw;width:75vw">
                           <table class="table_1" style="margin-left:-62vw">
                               <tr>
                                <td><h1 class="payment_title">Transaction list</h1></td>
                               </tr>
                            </table>
                            <hr>  
                            <div class="fieldset_3" style="height:30vw;"><table class="table_">
                                   <tr>
                                      <td colspan="3"><h3 class="date_"></h3></td>
                                   </tr>

<%
String driver = "com.mysql.jdbc.Driver";
String name = (String) session.getAttribute("user"); 
try {
    Class.forName(driver);
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/SDK_bank", "root", "19BCS0090");
    PreparedStatement ps = con.prepareStatement("SELECT Transaction_ID, account_number, to_account_number, amount, date_time,status FROM transaction_list WHERE account_number = ? OR to_account_number = ?");
    ps.setString(1, name);
    ps.setString(2, name);
    ResultSet rs = ps.executeQuery();
    int count=1;
while (rs.next()) {
    out.println("<tr>");
    out.println("<td><h3 class=\"order_list\" style=\"margin-left:1vw\">#"+count+" - Transaction ID: " + rs.getString("Transaction_ID") + "</h3></td>");
    out.println("<td><h3 class=\"order_list\">Account Number: " + rs.getString("account_number") + "</h3></td>");
    out.println("<td><h3 class=\"order_list\">To Account Number: " + rs.getString("to_account_number") + "</h3></td>");
    out.println("</tr><tr>");
    out.println("<td><h3 class=\"order_list\" style=\"margin-left:1vw\">Status: " + rs.getString("status") + "</h3></td>");
    out.println("<td><h3 class=\"order_list\">Amount: " + rs.getString("amount") + "</h3></td>");
    out.println("<td><h3 class=\"order_list\" style=\"float:left\">Date Time: " + rs.getString("date_time") + "</h3></td>");
    out.println("</tr>");
    count++;
}
} catch (Exception e) {
    out.print(e);
}
%>
                                </table>
                                <hr style="width:70vw">
                                </div>                 
                          </fieldset>
                       </center>
                    </body>
                </html>