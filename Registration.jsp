<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.concurrent.ThreadLocalRandom" %>
<%@ page import="com.twilio.Twilio" %>
<%@ page import="com.twilio.rest.api.v2010.account.Message" %>
<%@ page import="com.twilio.type.PhoneNumber" %>
<%
    String Firstname = request.getParameter("Firstname");
    String Lastname = request.getParameter("Lastname");
    String Date_of_birth = request.getParameter("Date_of_birth");
    String pnumber = request.getParameter("pnumber");
    String Fathername = request.getParameter("Fathername");
    String aadhar = request.getParameter("aadhar");
    String pancard = request.getParameter("pancard");
    String Address = request.getParameter("Address");
    String Pincode = request.getParameter("Pincode");
    String state = request.getParameter("state");
    String EmailID = request.getParameter("EmailID");
    String Password = request.getParameter("Password");

    Random random = new Random();
    int nu = ThreadLocalRandom.current().nextInt(1000000000);
    String accountNumber = Integer.toString(nu); 

    String driver = "com.mysql.jdbc.Driver";

    try {
        Class.forName(driver);
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/SDK_bank", "root", "19BCS0090");
        if (con != null) {
            try (PreparedStatement preparedStatement = con.prepareStatement("INSERT INTO User_registration (Account_number,Firstname,Lastname,Fathername,Aadhar_number,Pancard,Address,Pincode,State,Email_ID,Password,dob,phonenumber) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)")) {
                preparedStatement.setString(1, accountNumber);
                preparedStatement.setString(2, Firstname);
                preparedStatement.setString(3, Lastname);
                preparedStatement.setString(4, Fathername);
                preparedStatement.setString(5, aadhar);
                preparedStatement.setString(6, pancard);
                preparedStatement.setString(7, Address);
                preparedStatement.setString(8, Pincode);
                preparedStatement.setString(9, state);
                preparedStatement.setString(10, EmailID);
                preparedStatement.setString(11, Password);
                preparedStatement.setString(12, Date_of_birth);
                preparedStatement.setString(13, pnumber);

                int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    
                    String ACCOUNT_SID = "ACf60346bb7de97cdfa966086a5a9936b7";
                    String AUTH_TOKEN = "c2b773c3771ff8e91eb6de7df8c6384c";
                    String TWILIO_NUMBER = "+17209034894";
                    String recipientNumber = "+916301457870"; 

                    Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

                    String messageBody = "Your SDK City Bank account has been created successfully.\nAccount Number: " + accountNumber + "\nPassword: " + Password;

                    Message message = Message.creator(
                            new PhoneNumber(recipientNumber),
                            new PhoneNumber(TWILIO_NUMBER),
                            messageBody)
                            .create();
                    out.print("<script>alert('Registered successfully. SMS sent with account details');</script>");
                    out.print("<script>window.location.href='index.html';</script>");
                } else {
                    out.print("<script>alert('Registration failed');</script>");
                    out.print("<script>window.history.back();</script>");
                }
            } catch (SQLException e) {
                out.print("Error in SQL: " + e.getMessage());
            }
        } else {
            out.print("<h1>Unable to connect to the database</h1>");
        }
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
