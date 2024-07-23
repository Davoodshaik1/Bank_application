<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
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
    <title>View Customers</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f2f2f2;
        }
        .customer-list {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 0 auto;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="customer-list">
        <h2>View Customers</h2>
        
        <table>
            <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Mobile No</th>
                    <th>Account Type</th>
                    <th>Account Number</th>
                    <th>Date of Birth</th>
                    <th>ID Proof</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gen", "root", "Davood@43");
                        stmt = conn.createStatement();
                        String sql = "SELECT * FROM customers";
                        rs = stmt.executeQuery(sql);
                        
                        while(rs.next()) {
                %>
                            <tr>
                                <td><%= rs.getInt("id") %></td>
                                <td><%= rs.getString("full_name") %></td>
                                <td><%= rs.getString("email_id") %></td>
                                <td><%= rs.getString("address") %></td>
                                <td><%= rs.getString("mobile_no") %></td>
                                <td><%= rs.getString("account_type") %></td>
                                <td><%= rs.getLong("account_no") %></td>
                                <td><%= rs.getString("date_of_birth") %></td>
                                <td><%= rs.getString("id_proof") %></td>
                            </tr>
                <% 
                        }
                    } catch (SQLException e) {
                        out.println("SQL Exception: " + e.getMessage());
                    } catch (ClassNotFoundException e) {
                        out.println("Class Not Found Exception: " + e.getMessage());
                    } finally {
                        // Close resources in reverse order
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            out.println("Error closing database resources: " + e.getMessage());
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
