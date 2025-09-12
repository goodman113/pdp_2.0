<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Edit Group</title>
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
            align-items: center;
            justify-content: center;
            color: #e2e8f0;
            padding: 2rem;
        }

        .form-container {
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(59, 130, 246, 0.2);
            padding: 3rem;
            border-radius: 20px;
            box-shadow:
                    0 25px 50px rgba(0, 0, 0, 0.5),
                    0 0 0 1px rgba(59, 130, 246, 0.1);
            width: 100%;
            max-width: 500px;
        }

        h1 {
            color: #60a5fa;
            font-size: 2.2rem;
            margin-bottom: 2rem;
            text-align: center;
            font-weight: 700;
            text-shadow: 0 0 20px rgba(96, 165, 250, 0.3);
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        input, select {
            width: 100%;
            padding: 16px 20px;
            background: rgba(15, 23, 42, 0.8);
            border: 2px solid rgba(59, 130, 246, 0.3);
            border-radius: 12px;
            color: #e2e8f0;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow:
                    0 0 0 3px rgba(59, 130, 246, 0.1),
                    0 0 20px rgba(59, 130, 246, 0.2);
            background: rgba(15, 23, 42, 1);
            transform: translateY(-2px);
        }

        input::placeholder {
            color: #64748b;
        }

        button {
            padding: 16px 24px;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
            margin-top: 1rem;
        }

        button:hover {
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
            transform: translateY(-3px);
            box-shadow:
                    0 8px 25px rgba(59, 130, 246, 0.4),
                    0 0 20px rgba(59, 130, 246, 0.2);
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
            text-align: center;
        }

        .back-link:hover {
            background: #3b82f6;
            color: white;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="form-container">
    <h1>Edit Group</h1>

    <form action="/edit-group" method="post">
        <input type="hidden" name="id" value="${group.id}">
        <input type="text" name="groupName" placeholder="Enter name of group" value="${group.groupName}"/>
        <input type="time" name="startTime" value="${startTime}"/>
        <input type="time" name="endTime" value="${endTime}"/>
        <input type="number" name="module" placeholder="Module number" value="${module}">

        <select name="day">
            <c:forEach var="c" items="${days}">
                <option value="${c}" <c:if test="${c == group.lessonDays}">selected</c:if>>
                    <c:choose>
                        <c:when test="${c == 'ODD'}">Du, Ch, Ju</c:when>
                        <c:when test="${c == 'EVEN'}">Se, Pa, Sh</c:when>
                        <c:otherwise><c:out value="${c}"/></c:otherwise>
                    </c:choose>
                </option>
            </c:forEach>
        </select>

        <button type="submit">Update Group</button>
    </form>

    <a href="/group" class="back-link">← Back to Groups</a>
</div>
</body>
</html>
