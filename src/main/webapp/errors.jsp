<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Error Page</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 25%, #1e1e1e 50%, #0f0f0f 100%);
            margin: 0;
            padding: 2rem;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #e5e7eb;
        }

        .error-container {
            background: linear-gradient(145deg, #1f2937 0%, #111827 100%);
            border: 1px solid #374151;
            border-radius: 16px;
            box-shadow:
                    0 25px 50px rgba(0, 0, 0, 0.4),
                    0 10px 20px rgba(0, 0, 0, 0.3),
                    inset 0 1px 0 rgba(255, 255, 255, 0.1);
            padding: 3rem;
            text-align: center;
            max-width: 600px;
            width: 100%;
            position: relative;
        }

        h1 {
            color: #ef4444;
            font-size: 3rem;
            margin-bottom: 1rem;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(239, 68, 68, 0.3);
        }

        .error-message {
            color: #d1d5db;
            font-size: 1.2rem;
            margin-bottom: 2rem;
            line-height: 1.6;
            opacity: 0.9;
        }

        .back-link {
            display: inline-block;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: #ffffff;
            text-decoration: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .back-link:hover {
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
            transform: translateY(-3px);
            box-shadow:
                    0 8px 25px rgba(59, 130, 246, 0.4),
                    0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .error-icon {
            font-size: 4rem;
            color: #f59e0b;
            margin-bottom: 1rem;
            text-shadow: 0 2px 8px rgba(245, 158, 11, 0.4);
            filter: drop-shadow(0 0 10px rgba(245, 158, 11, 0.3));
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.05);
                opacity: 0.8;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }

        .error-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent, rgba(59, 130, 246, 0.1), transparent);
            border-radius: 16px;
            z-index: -1;
            opacity: 0.5;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-icon">⚠️</div>
    <h1>Oops!</h1>
    <div class="error-message">
        <c:out value="${message}"/>
    </div>
    <a href="/admin" class="back-link">← Back to Dashboard</a>
</div>
</body>
</html>
