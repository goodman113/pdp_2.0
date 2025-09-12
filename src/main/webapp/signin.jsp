<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        body{
            font-family: system-ui, Arial, sans-serif;
            background: linear-gradient(135deg,#3b82f6,#10b981);
            display:flex; align-items:center; justify-content:center;
            height:100vh; margin:0;
        }
        .container{
            background:#ffffff;
            padding:40px 30px;
            border-radius:16px;
            box-shadow:0 8px 25px rgba(0,0,0,0.2);
            text-align:center;
        }
        h1{
            margin-top:0;
            font-size:24px;
            color:#111827;
        }
        p{color:#6b7280; font-size:14px; margin-bottom:24px;}
        form{display:flex; flex-direction:column; gap:15px; margin:0;}
        input{
            padding:12px 14px;
            border:1px solid #d1d5db;
            border-radius:8px;
            font-size:15px;
            outline:none;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }
        input:focus{
            border-color:#3b82f6;
            box-shadow:0 0 0 3px rgba(59,130,246,0.3);
        }

        /* 🔥 Prettier button */
        button{
            padding:14px 20px;
            font-size:16px;
            font-weight:600;
            border:none;
            border-radius:10px;
            cursor:pointer;
            background: linear-gradient(135deg,#2563eb,#1d4ed8);
            color:white;
            box-shadow:0 4px 14px rgba(37,99,235,0.4);
            transition: all 0.2s ease-in-out;
        }
        button:hover{
            background: linear-gradient(135deg,#1e40af,#1d4ed8);
            transform: translateY(-2px);
            box-shadow:0 6px 18px rgba(37,99,235,0.5);
        }
        button:active{
            transform: scale(0.96);
        }
    </style>
</head>
<body>
<div class="container">
    <h1><c:out value="${message}" /></h1>
    <form action="/signin" method="post">
        <input type="text" name="number" placeholder="Enter number">
        <input type="password" name="password" placeholder="Enter password">
        <button type="submit">🚀 Sign In</button>
    </form>
</div>
</body>
</html>
