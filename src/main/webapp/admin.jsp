<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #e2e8f0;
            padding: 2rem;
        }

        .dashboard-container {
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(59, 130, 246, 0.2);
            border-radius: 20px;
            padding: 3rem;
            box-shadow:
                    0 25px 50px rgba(0, 0, 0, 0.5),
                    0 0 0 1px rgba(59, 130, 246, 0.1);
            text-align: center;
            min-width: 400px;
        }

        h1 {
            color: #60a5fa;
            font-size: 2.5rem;
            margin-bottom: 2rem;
            font-weight: 700;
            text-shadow: 0 0 20px rgba(96, 165, 250, 0.3);
        }

        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        a {
            display: inline-block;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: #ffffff;
            text-decoration: none;
            padding: 1.2rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        a:hover {
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
            transform: translateY(-3px);
            box-shadow:
                    0 8px 25px rgba(59, 130, 246, 0.4),
                    0 0 20px rgba(59, 130, 246, 0.2);
        }

        hr {
            border: none;
            height: 1px;
            background: linear-gradient(90deg, transparent, #3b82f6, transparent);
            margin: 1.5rem 0;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <h1>Admin Dashboard</h1>
    <div class="nav-links">
        <a href="/users">Manage Users</a>
        <hr>
        <a href="/group">Manage Groups</a>
    </div>
</div>
</body>
</html>
