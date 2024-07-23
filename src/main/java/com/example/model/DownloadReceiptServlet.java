package com.example.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.web.Transaction;

@WebServlet("/DownloadReceiptServlet")
public class DownloadReceiptServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get transaction details from session or request attributes
        List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactionList");

        // Set response content type
        response.setContentType("text/plain");
        response.setHeader("Content-Disposition", "attachment;filename=receipt.txt");

        // Generate receipt content
        try (PrintWriter out = response.getWriter()) {
            out.println("Receipt for Transactions:\n");
            for (Transaction transaction : transactions) {
                out.println("Transaction ID: " + transaction.getId());
                out.println("Date: " + transaction.getDate());
                out.println("Description: " + transaction.getDescription());
                out.println("Amount: " + transaction.getAmount());
                out.println("Balance: " + transaction.getBalance() + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
