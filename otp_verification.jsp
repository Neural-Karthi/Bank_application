<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.concurrent.ThreadLocalRandom" %>
<%@ page import="com.twilio.Twilio" %>
<%@ page import="com.twilio.rest.api.v2010.account.Message" %>
<%@ page import="com.twilio.type.PhoneNumber" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    Date currentDate = new Date();
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
    String formattedDate = dateFormat.format(currentDate);
    String formattedTime = timeFormat.format(currentDate);
    String dateandtime=formattedTime+" "+formattedDate;
%>
<%
    String acc_number = (String) session.getAttribute("user");
    String from_acc_number = request.getParameter("from_acc_number");
    String to_acc_number = request.getParameter("to_acc_number");
    String amount = request.getParameter("amount");
    String generatedOTP = request.getParameter("generatedOTP");
    String user_otp = request.getParameter("user_otp");
    String driver = "com.mysql.jdbc.Driver";
    Random random = new Random();
    int nu = ThreadLocalRandom.current().nextInt(1000000000);
    String transaction_id = Integer.toString(nu);
    if (user_otp.equals(generatedOTP)) {
        try {
            Class.forName(driver);
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/SDK_bank", "root", "19BCS0090");
            PreparedStatement preparedStatement_1 = con.prepareStatement("UPDATE account_details SET Balance = Balance - ? WHERE account_number = ?");
            preparedStatement_1.setBigDecimal(1, new BigDecimal(amount));
            preparedStatement_1.setString(2, from_acc_number);
            int rowsUpdated_1 = preparedStatement_1.executeUpdate();
            PreparedStatement preparedStatement_2 = con.prepareStatement("UPDATE account_details SET Balance = Balance + ? WHERE account_number = ?");
            preparedStatement_2.setBigDecimal(1, new BigDecimal(amount));
            preparedStatement_2.setString(2, to_acc_number);
            int rowsUpdated_2 = preparedStatement_2.executeUpdate();

            if (rowsUpdated_1 > 0 && rowsUpdated_2 > 0) {
                  try (PreparedStatement preparedStatement = con.prepareStatement("INSERT INTO transaction_list (Transaction_ID,account_number,to_account_number,amount,date_time,status) VALUES (?,?,?,?,?,?)")) {
                    preparedStatement.setString(1, transaction_id);
                    preparedStatement.setString(2, from_acc_number);
                    preparedStatement.setString(3, to_acc_number);
                    preparedStatement.setString(4, amount);
                    preparedStatement.setString(5, dateandtime);
                     preparedStatement.setString(6, "Debited");
                      int rowsInserted3 = preparedStatement.executeUpdate();
                      if (rowsInserted3 > 0) 
                      {
                    String ACCOUNT_SID = "ACf60346bb7de97cdfa966086a5a9936b7";
                    String AUTH_TOKEN = "c2b773c3771ff8e91eb6de7df8c6384c";
                    String TWILIO_NUMBER = "+17209034894";
                    String recipientNumber = "+916301457870"; 

                    Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

                    String messageBody = "Transaction Completed successfully "+amount+" - Amount debited from your account and credited to account no : "+to_acc_number;

                    Message message = Message.creator(
                            new PhoneNumber(recipientNumber),
                            new PhoneNumber(TWILIO_NUMBER),
                            messageBody)
                            .create();
                    out.print("<script>alert('successfully Changed. SMS sent your phone number');</script>");
                    out.print("<script>alert('Amount successfully transfered');</script>");
                      }
                  }
                   catch (SQLException e) {
                       out.print("Error in SQL: " + e.getMessage());
                   }
            } else {
                
                out.print("<script>alert('Failed to transfer amount');</script>");
            }
        } catch (SQLException | ClassNotFoundException e) {
            out.print("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
    } else {
        out.print("<script>alert('Invalid OTP');</script>");
        out.print("<script>window.history.back();</script>");
    }
%>
