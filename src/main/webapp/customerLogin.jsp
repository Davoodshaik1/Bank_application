<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Login</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: #0e031a;
            font-family: Lato, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
            color: #fff;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .login-container {
            background-color: #1c1c1c;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            margin: 0 auto;
            text-align: center;
            transform: translateX(100%);
            transition: transform 0.5s;
        }

        .login-container h2 {
            color: #fff;
        }

        .login-container form {
            display: inline-block;
            width: 100%;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #333;
            color: #fff;
        }

        .login-container input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .login-container input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Customer Login</h2>
        
        <form action="CustomerLoginServlet" method="post">
            <input type="text" name="account_no" placeholder="Account Number" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>
        
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <p class="error"><%= error %></p>
        <%
            }
        %>
    </div>

    <script>
        window.onload = () => {
            const container = document.querySelector('.login-container');
            container.style.transform = 'translateX(0)';
        };
    </script>
</body>
</html>
