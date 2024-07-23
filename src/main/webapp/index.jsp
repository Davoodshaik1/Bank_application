<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Type</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #0e031a;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #fff;
        }
        .type-selector-container {
            background-color: #1c1c1c;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
            transition: transform 0.5s;
        }
        .type-selector-container h2 {
            margin-bottom: 20px;
            color: #fff;
        }
        .type-selector-container button {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #007BFF;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .type-selector-container button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="type-selector-container">
        <h2>Select User Type</h2>
        <!-- Redirect to adminLogin.jsp when Admin button is clicked -->
        <button onclick="navigateTo('adminlogin.jsp')">Admin</button>
        <!-- Redirect to customerLogin.jsp when Customer button is clicked -->
        <button onclick="navigateTo('customerLogin.jsp')">Customer</button>
    </div>

    <script>
        function navigateTo(page) {
            const container = document.querySelector('.type-selector-container');
            container.style.transform = 'translateX(-100%)';
            setTimeout(() => {
                window.location.href = page;
            }, 500);
        }
    </script>
</body>
</html>
