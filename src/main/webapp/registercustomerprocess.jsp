<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Random" %>
<!DOCTYPE html>
<%
     session = request.getSession(false);
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Customer Process</title>
</head>
<body>
    <%!
        // Method to generate a random 11-digit account number
        long generateAccountNumber() {
            Random rand = new Random();
            long accountNumber = (long) (rand.nextDouble() * 1000000000000L);
            return accountNumber;
        }

        // Method to generate a random 4-digit temporary password
        int generateTempPassword() {
            Random rand = new Random();
            int tempPassword = rand.nextInt(10000);
            return tempPassword;
        }
    %>

    <%
        // Retrieve form data
        String fullName = request.getParameter("full_name");
        String address = request.getParameter("address");
        String mobileNo = request.getParameter("mobile_no");
        String email = request.getParameter("email_id");
        String accountType = request.getParameter("account_type");
        int initialBalance = Integer.parseInt(request.getParameter("initial_balance"));
        String dob = request.getParameter("date_of_birth");
        String idProof = request.getParameter("id_proof");

        // Generate account number and temporary password
        long accountNo = generateAccountNumber();
        int tempPassword = generateTempPassword();

        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/gen";
        String dbUsername = "root";
        String dbPassword = "Davood@43";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Register JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Open a connection
            conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

            // Insert customer data into database
            String sql = "INSERT INTO customers (full_name, address, mobile_no, email_id, account_type, initial_balance, date_of_birth, id_proof, account_no, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fullName);
            pstmt.setString(2, address);
            pstmt.setString(3, mobileNo);
            pstmt.setString(4, email);
            pstmt.setString(5, accountType);
            pstmt.setInt(6, initialBalance);
            pstmt.setString(7, dob);
            pstmt.setString(8, idProof);
            pstmt.setLong(9, accountNo);
            pstmt.setInt(10, tempPassword);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                %>
                <h2>Customer registered successfully!</h2>
                <p>Account Number: <%= accountNo %></p>
                <p>Temporary Password: <%= tempPassword %></p>
                <%
            } else {
                %>
                <h2>Failed to register customer. Please try again.</h2>
                <%
            }
        } catch (SQLException | ClassNotFoundException ex) {
            out.println("<h2>Error occurred: " + ex.getMessage() + "</h2>");
            ex.printStackTrace();
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    %>
</body>
</html>
