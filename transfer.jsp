 <%@ page import="java.sql.*" %>

<%
String name=(String)session.getAttribute("user");  
  
%>
 <!DOCTYPE html>
          <html lang="en">
             <head><title>
             fund transfer
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
                   <td><h1 class="payment_title" style="margin-left:-23vw">FUND TRANSFER</h1></td>
                </tr>
             </table>
             <hr>
             <div  style="display:flex">
                  <div class="payment_selection">
                     <button class="button_1" id="button_1" onclick="debit_Card()">
                         <table class="">
                           <tr>
                               <td><h3 class="debit_card_text">SELF PAY</h3></td>
                           </tr>
                         </table>
                     </button>
                        <button class="button_2" id="button_2" onclick="upi()">
                         <table class="">
                           <tr>
                               <td><h3 class="debit_card_text">BENE PAY</h3></td>
                           </tr>
                         </table>
                     </button>
                   
                  </div>
                 <div class="payment_view">
                       <div id="debit_card_details" >
                      <form method="POST" action="amount_transfer.jsp" onsubmit="return validateTransfer()">
                     <table class="payment_card_details" style="margin-top:4vw">
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
                                  <input type="text" name="old_password" id="old_password" value="<%=name%>"class="input" disabled>
                                  <label style="margin-top:-2.5vw;margin-left:-0.70vw">From</label>
                              </div>
                            </td> 
                            <td>
                              <div class="group" id="group_input">      
                                  <input type="text" name="to_acc_number" id="to_acc_number" class="input" >
                                  <label>To</label>
                              </div>
                           </td>                                          
                       </tr>
                       <tr>
                               <td>
                              <div class="group" id="group_input">      
                                  <input type="text" name="amount" id="amount" class="input" >
                                  <label>Amount</label>
                                  <%
                                    String driver = "com.mysql.jdbc.Driver";
    try {
    Class.forName(driver);
     Connection con = DriverManager.getConnection("jdbc:mysql://localhost/SDK_bank", "root", "19BCS0090");
     Statement s = con.createStatement();
     ResultSet rs = s.executeQuery("SELECT account_number,Balance FROM account_details");
     int flag=0;
     while(rs.next()){
          String user=rs.getString("account_number");
          String password=rs.getString("Balance");
          if(user.equals(name)) {
                    out.print("<p style=\"position:absolute\">avaliable fund : "+password+"</p>");
                    session.setAttribute("amount", password);
          }
     }
    }catch(Exception e){
       out.print(e);
    }
                                  %>
                              </div>
                            </td> 
                            <td>
                              <div class="group" id="group_input">      
                                  <input type="text" name="Remarks" id="Remarks" class="input" >
                                  <label>Remarks(Optional)</label>
                              </div>
                           </td>                                          
                       </tr>
                      
                        <tr>
                          <td>
                               <button class="check_out" name="button2"  onclick="goBack()" id="button_upi" >Cancel</button>
                          </td>
                          <td>
                               <button class="check_out" name="submit" id="button_upi" >Transfer</button>
                          </td>
                       </tr>
                       </form>
                       <%
String amount_avalible=(String)session.getAttribute("amount");  
%>
                     </table>
                          <script>
      function goBack() {
         window.parent.location.href='Home.html';
      }

    function validateTransfer() {
      // Get the entered amount and available balance
      var enteredAmount = parseFloat(document.getElementById('amount').value);
      var availableBalance = parseFloat('<%= amount_avalible %>'); // Fetch available balance from JSP

      // Check if the entered amount is greater than the available balance
      if (enteredAmount > availableBalance) {
        alert('Entered amount is greater than available balance');
        return false; // Prevent form submission if validation fails
      }

      // If validation passes, allow form submission
      return true;
    }
  </script>
                       </div>
                        
                    <div id="UPI_details">
                     <table class="payment_card_details" style="margin-top:4vw">
                         <h1>ERROR 503 - under Construction</h1>
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