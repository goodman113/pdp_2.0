<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Students to Group</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
            color: #e2e8f0;
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .header {
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 12px;
            border: 1px solid rgba(96, 165, 250, 0.2);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            margin-bottom: 2rem;
        }

        .header h1 {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #60a5fa;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .group-info {
            background: rgba(59, 130, 246, 0.1);
            padding: 1.2rem;
            border-radius: 8px;
            border: 1px solid rgba(59, 130, 246, 0.3);
            margin-top: 1rem;
        }

        .group-info strong {
            color: #93c5fd;
        }

        .capacity-info {
            background: rgba(14, 165, 233, 0.15);
            border: 1px solid rgba(14, 165, 233, 0.4);
            padding: 1.2rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            backdrop-filter: blur(5px);
        }

        .capacity-info strong {
            color: #0ea5e9;
        }

        .form-container {
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 12px;
            border: 1px solid rgba(96, 165, 250, 0.2);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        .students-grid {
            display: grid;
            gap: 0.75rem;
            margin-bottom: 2rem;
        }

        .student-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            border: 1px solid rgba(71, 85, 105, 0.5);
            border-radius: 8px;
            background: rgba(51, 65, 85, 0.3);
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .student-item:hover {
            border-color: #60a5fa;
            background: rgba(96, 165, 250, 0.1);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(96, 165, 250, 0.2);
        }

        .student-item.disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }

        .student-checkbox {
            margin-right: 1rem;
            width: 18px;
            height: 18px;
            accent-color: #3b82f6;
            cursor: pointer;
        }

        .student-info {
            flex: 1;
        }

        .student-name {
            font-weight: 500;
            margin-bottom: 0.25rem;
            color: #f1f5f9;
        }

        .student-phone {
            color: #94a3b8;
            font-size: 0.875rem;
        }

        .selected-count {
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid #0ea5e9;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            text-align: center;
            color: #0ea5e9;
            font-weight: 600;
            backdrop-filter: blur(5px);
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            font-size: 0.95rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .btn-primary:hover:not(:disabled) {
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(59, 130, 246, 0.4);
        }

        .btn-primary:disabled {
            background: #475569;
            cursor: not-allowed;
            box-shadow: none;
            transform: none;
        }

        .btn-secondary {
            background: rgba(71, 85, 105, 0.8);
            color: #e2e8f0;
            border: 1px solid rgba(148, 163, 184, 0.3);
        }

        .btn-secondary:hover {
            background: rgba(100, 116, 139, 0.8);
            border-color: rgba(148, 163, 184, 0.5);
            transform: translateY(-2px);
        }

        .error-message {
            background: rgba(220, 38, 38, 0.1);
            border: 1px solid rgba(248, 113, 113, 0.4);
            color: #fca5a5;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            backdrop-filter: blur(5px);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Add Students to Group</h1>
        <div class="group-info">
            <strong>Group:</strong> ${group.groupName}<br>
            <strong>Teacher:</strong> ${group.teacher.name} ${group.teacher.surname}<br>
            <strong>Room:</strong> ${group.room.number}
        </div>
    </div>

    <div class="capacity-info">
        <strong>Room Capacity:</strong> ${roomCapacity} students<br>
        <strong>Current Students:</strong> ${currentStudents}<br>
        <strong>Available Spots:</strong> ${remainingCapacity}
    </div>

    <c:if test="${not empty error}">
        <div class="error-message">
                ${error}
        </div>
    </c:if>

    <div class="form-container">
        <form action="/students" method="post" id="addStudentsForm">
            <input type="hidden" name="action" value="addStudents">
            <input type="hidden" name="groupId" value="${group.id}">

            <div class="selected-count" id="selectedCount" style="display: none;">
                Selected: <span id="countText">0</span> / ${remainingCapacity} students
            </div>

            <div class="students-grid">
                <c:forEach var="student" items="${availableStudents}">
                    <div class="student-item">
                        <input type="checkbox"
                               name="selectedStudents"
                               value="${student.id}"
                               class="student-checkbox"
                               onchange="updateSelection()">
                        <div class="student-info">
                            <div class="student-name">${student.name} ${student.surname}</div>
                            <div class="student-phone">${student.phoneNumber}</div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty availableStudents}">
                <div style="text-align: center; padding: 2rem; color: #64748b;">
                    No available students to add to this group.
                </div>
            </c:if>

            <div class="button-group">
                <a href="/group?id=${group.id}" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary" id="submitBtn" disabled>
                    Add Selected Students
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    const maxSelection = ${remainingCapacity};

    function updateSelection() {
        const checkboxes = document.querySelectorAll('input[name="selectedStudents"]:checked');
        const selectedCount = checkboxes.length;
        const countDisplay = document.getElementById('selectedCount');
        const countText = document.getElementById('countText');
        const submitBtn = document.getElementById('submitBtn');

        countText.textContent = selectedCount;
        countDisplay.style.display = selectedCount > 0 ? 'block' : 'none';

        submitBtn.disabled = selectedCount === 0;

        const allCheckboxes = document.querySelectorAll('input[name="selectedStudents"]');
        allCheckboxes.forEach(checkbox => {
            if (!checkbox.checked) {
                checkbox.disabled = selectedCount >= maxSelection;
                checkbox.closest('.student-item').classList.toggle('disabled', selectedCount >= maxSelection);
            }
        });
    }
</script>
</body>
</html>
