<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Users Management</title>
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
            color: #e2e8f0;
            padding: 2rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        h1 {
            color: #60a5fa;
            font-size: 2.5rem;
            margin-bottom: 2rem;
            text-align: center;
            font-weight: 700;
            text-shadow: 0 0 20px rgba(96, 165, 250, 0.3);
        }

        form {
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(59, 130, 246, 0.2);
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            margin-bottom: 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            align-items: end;
        }

        input, select {
            width: 100%;
            padding: 12px 16px;
            background: rgba(15, 23, 42, 0.8);
            border: 2px solid rgba(59, 130, 246, 0.3);
            border-radius: 8px;
            color: #e2e8f0;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            background: rgba(15, 23, 42, 1);
        }

        input::placeholder {
            color: #64748b;
        }

        button {
            padding: 12px 24px;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
        }

        button:hover {
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.4);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(59, 130, 246, 0.2);
        }

        th, td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid rgba(59, 130, 246, 0.1);
        }

        th {
            background: linear-gradient(135deg, #1e40af 0%, #1d4ed8 100%);
            color: #ffffff;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        tr:nth-child(even) {
            background: rgba(15, 23, 42, 0.3);
        }

        tr:hover {
            background: rgba(59, 130, 246, 0.1);
            transform: scale(1.01);
            transition: all 0.2s ease;
        }

        td button {
            padding: 8px 16px;
            font-size: 0.9rem;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        }

        td button:hover {
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
        }

        hr {
            border: none;
            height: 1px;
            background: linear-gradient(90deg, transparent, #3b82f6, transparent);
            margin: 2rem 0;
        }

        .back-link {
            display: inline-block;
            color: #60a5fa;
            text-decoration: none;
            font-weight: 600;
            padding: 12px 24px;
            border: 2px solid #3b82f6;
            border-radius: 8px;
            transition: all 0.3s ease;
            margin-top: 2rem;
        }

        .back-link:hover {
            background: #3b82f6;
            color: white;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Users Management</h1>

    <form action="users" method="post">
        <input type="text" name="name" placeholder="Enter name">
        <input type="text" name="surname" placeholder="Enter surname">
        <input type="number" name="phoneNumber" placeholder="Enter phone number">
        <input type="text" name="password" placeholder="Enter password">
        <select name="role">
            <c:forEach var="r" items="${roles}">
                <option value="${r}">${r}</option>
            </c:forEach>
        </select>
        <button type="submit">Create User</button>
    </form>

    <hr>

    <table>
        <tr>
            <th>Name</th>
            <th>Surname</th>
            <th>Phone Number</th>
            <th>Password</th>
            <th>Role</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="u" items="${users}">
            <tr>
                <td><c:out value="${u.name}"/></td>
                <td><c:out value="${u.surname}"/></td>
                <td><c:out value="${u.phoneNumber}"/></td>
                <td><c:out value="${u.password}"/></td>
                <td><c:out value="${u.role}"/></td>
                <td><c:out value="${u.is_Active}"/></td>
                <td>
                    <a href="/edit-user?id=${u.id}">
                        <button>Edit</button>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <hr>
    <a href="/admin.jsp" class="back-link">← Back to Dashboard</a>
</div>
</body>
</html>
