package com.example.model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("account_no");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gen", "root", "Davood@43");
            
            // Prepare SQL statement
            pst = conn.prepareStatement("SELECT * FROM customers WHERE account_no = ? AND password = ?");
            pst.setString(1, accountNo);
            pst.setString(2, password);
            
            // Execute query
            rs = pst.executeQuery();

            if (rs.next()) {
                // Valid login: set session attributes
                HttpSession session = request.getSession();
                session.setAttribute("customerUser", accountNo);
                session.setAttribute("account_no", accountNo); // Ensure account_no is set
                session.setAttribute("initial_balance", rs.getDouble("initial_balance"));

                // Redirect to dashboard
                response.sendRedirect("customerdashboard.jsp");
            } else {
                // Invalid login: redirect with error message
                response.sendRedirect("customerLogin.jsp?error=Invalid%20account%20number%20or%20password");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("customerLogin.jsp?error=An%20error%20occurred");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
