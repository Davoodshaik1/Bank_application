<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
    <title>Update Customer</title>
    <style>
        /* Your CSS styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f2f2f2;
        }
        .message {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
            text-align: center;
        }
        .success {
            color: green;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="message">
        <h2>Update Customer</h2>
        
        <%
            // Retrieve the form data
            String customerId = request.getParameter("id");
            String fullName = request.getParameter("fullName");
            String address = request.getParameter("address");
            String mobileNo = request.getParameter("mobileNo");
            String email = request.getParameter("email");
            String accountType = request.getParameter("accountType");
            String balanceStr = request.getParameter("balance");
            String dob = request.getParameter("dob");
            String idProof = request.getParameter("idProof");
            
            double balance = 0.0;
            try {
                balance = Double.parseDouble(balanceStr);
            } catch (NumberFormatException e) {
                out.println("<p class='error'>Invalid balance value.</p>");
            }
            
            if (customerId == null || customerId.isEmpty()) {
                out.println("<p class='error'>Customer ID is missing.</p>");
            } else {
                try {
                    // Load the MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Connect to the database
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gen", "root", "Davood@43");
                    
                    // Update query to modify customer details
                    String sql = "UPDATE customers SET full_name = ?, address = ?, mobile_no = ?, email_id = ?, account_type = ?, initial_balance = ?, date_of_birth = ?, id_proof = ? WHERE id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, fullName);
                    stmt.setString(2, address);
                    stmt.setString(3, mobileNo);
                    stmt.setString(4, email);
                    stmt.setString(5, accountType);
                    stmt.setDouble(6, balance);
                    stmt.setString(7, dob);
                    stmt.setString(8, idProof);
                    stmt.setInt(9, Integer.parseInt(customerId));
                    
                    int rowsUpdated = stmt.executeUpdate();
                    
                    if (rowsUpdated > 0) {
                        out.println("<p class='success'>Customer details updated successfully.</p>");
                    } else {
                        out.println("<p class='error'>Error: Customer not found or no changes made.</p>");
                    }
                    
                    // Close the resources
                    stmt.close();
                    conn.close();
                    
                } catch (SQLException e) {
                    out.println("<p class='error'>SQL Exception: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    out.println("<p class='error'>JDBC Driver not found: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
