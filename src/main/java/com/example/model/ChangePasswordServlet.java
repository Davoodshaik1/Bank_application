package com.example.model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("changePassword.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String accountNo = (String) session.getAttribute("customerUser");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        Connection conn = null;
        PreparedStatement pstSelect = null;
        PreparedStatement pstUpdate = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gen", "root", "Davood@43");

            String selectSql = "SELECT password FROM customers WHERE account_no = ?";
            pstSelect = conn.prepareStatement(selectSql);
            pstSelect.setLong(1, Long.parseLong(accountNo));
            rs = pstSelect.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                if (storedPassword.equals(currentPassword)) {
                    String updateSql = "UPDATE customers SET password = ? WHERE account_no = ?";
                    pstUpdate = conn.prepareStatement(updateSql);
                    pstUpdate.setString(1, newPassword);
                    pstUpdate.setLong(2, Long.parseLong(accountNo));
                    pstUpdate.executeUpdate();

                    response.sendRedirect("changePassword.jsp?success=Password%20successfully%20changed");
                } else {
                    response.sendRedirect("changePassword.jsp?error=Current%20password%20is%20incorrect");
                }
            } else {
                response.sendRedirect("customerdashboard.jsp?error=Account%20not%20found");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("customerdashboard.jsp?error=An%20error%20occurred");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstSelect != null) pstSelect.close();
                if (pstUpdate != null) pstUpdate.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
