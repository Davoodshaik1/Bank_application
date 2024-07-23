<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
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
    <title>Modify Customer</title>
    <style>
        /* Your CSS styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f2f2f2;
        }
        .customer-form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        h2 {
            text-align: center;
        }
        form div {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"],
        input[type="date"],
        select {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="customer-form">
        <h2>Modify Customer</h2>

        <form method="post" action="modifycustomers.jsp">
            <div>
                <label for="id">Enter Customer ID:</label>
                <input type="text" id="id" name="id" required>
            </div>
            <div>
                <input type="submit" value="Fetch Customer Details">
            </div>
        </form>

        <%
            // Retrieve the 'id' parameter from the form submission
            String customerId = request.getParameter("id");
            
            // Check if id is provided
            if (customerId != null && !customerId.isEmpty()) {
                try {
                    // Load the MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Connect to the database
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gen", "root", "Davood@43");

                    // SQL query to get customer details based on the provided ID
                    String sql = "SELECT * FROM customers WHERE id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, Integer.parseInt(customerId));

                    // Execute the query
                    ResultSet rs = stmt.executeQuery();

                    // Check if the customer exists
                    if (rs.next()) {
                        String fullName = rs.getString("full_name");
                        String address = rs.getString("address");
                        String mobileNo = rs.getString("mobile_no");
                        String email = rs.getString("email_id");
                        String accountType = rs.getString("account_type");
                        double balance = rs.getDouble("initial_balance");
                        java.sql.Date dob = rs.getDate("date_of_birth");
                        String idProof = rs.getString("id_proof");

                        // Format the date to yyyy-MM-dd for the date input
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        String formattedDob = dateFormat.format(dob);
        %>
                        <!-- Display the form with customer details -->
                        <form method="post" action="updatecustomer.jsp">
                            <div>
                                <label for="fullName">Full Name:</label>
                                <input type="text" id="fullName" name="fullName" value="<%= fullName %>" required>
                            </div>
                            <div>
                                <label for="address">Address:</label>
                                <input type="text" id="address" name="address" value="<%= address %>" required>
                            </div>
                            <div>
                                <label for="mobileNo">Mobile No:</label>
                                <input type="text" id="mobileNo" name="mobileNo" value="<%= mobileNo %>" required>
                            </div>
                            <div>
                                <label for="email">Email:</label>
                                <input type="email" id="email" name="email" value="<%= email %>" required>
                            </div>
                            <div>
                                <label for="accountType">Account Type:</label>
                                <select id="accountType" name="accountType" required>
                                    <option value="Saving" <%= accountType.equals("Saving") ? "selected" : "" %>>Saving</option>
                                    <option value="Current" <%= accountType.equals("Current") ? "selected" : "" %>>Current</option>
                                </select>
                            </div>
                            <div>
                                <label for="balance">Balance:</label>
                                <input type="text" id="balance" name="balance" value="<%= balance %>" required>
                            </div>
                            <div>
                                <label for="dob">Date of Birth:</label>
                                <input type="date" id="dob" name="dob" value="<%= formattedDob %>" required>
                            </div>
                            <div>
                                <label for="idProof">ID Proof:</label>
                                <input type="text" id="idProof" name="idProof" value="<%= idProof %>" required>
                            </div>
                            <!-- Hidden field to pass the customer ID -->
                            <input type="hidden" name="id" value="<%= customerId %>">
                            <div>
                                <input type="submit" value="Update Customer">
                            </div>
                        </form>
        <%
                    } else {
                        // If customer is not found
                        out.println("<p>Error: Customer not found.</p>");
                    }

                    // Close the resources
                    rs.close();
                    stmt.close();
                    conn.close();

                } catch (SQLException e) {
                    // Print SQL error
                    out.println("<p>SQL Exception: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    // Print error if JDBC driver is not found
                    out.println("<p>JDBC Driver not found: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            } else {
                // Display error if id is not provided
                out.println("<p>Error: Customer ID parameter not provided.</p>");
            }
        %>
    </div>
</body>
</html>
