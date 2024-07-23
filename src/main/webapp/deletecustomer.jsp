<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Customer</title>
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
        .form-container {
            max-width: 400px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-container label {
            display: block;
            margin-bottom: 10px;
        }
        .form-container input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-container input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="message">
        <h2>Delete Customer</h2>
        
        <div class="form-container">
            <form method="post" action="deletecustomer.jsp">
                <label for="accountNumber">Enter Customer Account Number:</label>
                <input type="text" id="accountNumber" name="account_no" required>
                <input type="submit" value="Delete Customer">
            </form>
        </div>
        
        <%
            // Check if account number is provided in the form submission
            String accountNumber = request.getParameter("account_no");
            
            if (accountNumber != null && !accountNumber.isEmpty()) {
                try {
                    // Load the MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Connect to the database
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gen", "root", "Davood@43");
                    
                    // Delete query to remove customer from database
                    String sql = "DELETE FROM customers WHERE account_no = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setLong(1, Long.parseLong(accountNumber));
                    
                    int rowsDeleted = stmt.executeUpdate();
                    
                    if (rowsDeleted > 0) {
                        out.println("<p class='success'>Customer deleted successfully.</p>");
                    } else {
                        out.println("<p class='error'>Error: Customer not found or could not be deleted.</p>");
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
            } else if (accountNumber != null && accountNumber.isEmpty()) {
                out.println("<p class='error'>Account Number cannot be empty.</p>");
            }
        %>
    </div>
</body>
</html>
