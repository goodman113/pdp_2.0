<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Selection Form</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
            color: #e2e8f0;
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            font-family: Arial, sans-serif;
        }

        .selection-group {
            margin-bottom: 30px;
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(10px);
            padding: 1.5rem;
            border-radius: 12px;
            border: 1px solid rgba(96, 165, 250, 0.2);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        .section-title h3 {
            margin-bottom: 15px;
            color: #f1f5f9;
            border-bottom: 2px solid #3b82f6;
            padding-bottom: 5px;
            font-size: 1.2rem;
        }

        .selection-item {
            padding: 12px 15px;
            margin: 8px 0;
            border: 2px solid rgba(71, 85, 105, 0.5);
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: rgba(51, 65, 85, 0.3);
            user-select: none;
            backdrop-filter: blur(5px);
            color: #e2e8f0;
        }

        .selection-item:hover {
            border-color: #60a5fa;
            background: rgba(96, 165, 250, 0.1);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(96, 165, 250, 0.2);
        }

        .selection-item.selected {
            border-color: #3b82f6;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            font-weight: bold;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .selection-item.selected:hover {
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
            border-color: #2563eb;
        }

        .save-button {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
            font-weight: 600;
        }

        .save-button:hover:not(:disabled) {
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
        }

        .save-button:disabled {
            background: #475569;
            cursor: not-allowed;
            opacity: 0.6;
            box-shadow: none;
            transform: none;
        }

        .form-validation {
            color: #fca5a5;
            font-size: 14px;
            margin-top: 10px;
            display: none;
            background: rgba(220, 38, 38, 0.1);
            border: 1px solid rgba(248, 113, 113, 0.4);
            padding: 0.75rem;
            border-radius: 6px;
            backdrop-filter: blur(5px);
        }

        .selection-counter {
            font-size: 14px;
            color: #94a3b8;
            margin-top: 10px;
            background: rgba(15, 23, 42, 0.6);
            padding: 0.5rem;
            border-radius: 6px;
            border: 1px solid rgba(71, 85, 105, 0.3);
            backdrop-filter: blur(5px);
        }
    </style>
</head>
<body>
<div class="container">
    <form id="selectionForm" method="post" action="/group">

        <div class="selection-group">
            <div class="section-title">
                <h3>Choose the room:</h3>
            </div>
            <div id="roomSelection">
                <c:forEach var="room" items="${rooms}" varStatus="status">
                    <div class="selection-item" data-type="room" data-value="${room.id}">
                            ${status.index + 1}. ${room.number} (capacity: ${room.capacity})
                    </div>
                </c:forEach>
            </div>
            <div class="selection-counter" id="roomCounter">Selected: 0/1</div>
            <input type="hidden" id="selectedRoomId" name="roomId" value="">
            <input type="hidden" name="groupId" value="${group.id}">
        </div>

        <div class="selection-group">
            <div class="section-title">
                <h3>Choose the teacher:</h3>
            </div>
            <div id="teacherSelection">
                <c:forEach var="teacher" items="${teachers}" varStatus="status">
                    <div class="selection-item" data-type="teacher" data-value="${teacher.id}">
                            ${status.index + 1}. ${teacher.name} ${teacher.surname}
                    </div>
                </c:forEach>
            </div>
            <div class="selection-counter" id="teacherCounter">Selected: 0/1</div>
            <input type="hidden" id="selectedTeacherId" name="teacherId" value="">
        </div>

        <div class="form-validation" id="validationMessage">
            Please select both a room and a teacher to continue.
        </div>

        <button type="submit" class="save-button" id="saveButton" disabled>
            Next
        </button>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('selectionForm');
        const saveButton = document.getElementById('saveButton');
        const validationMessage = document.getElementById('validationMessage');
        const roomCounter = document.getElementById('roomCounter');
        const teacherCounter = document.getElementById('teacherCounter');
        let selectedRoom = null;
        let selectedTeacher = null;
        document.querySelectorAll('.selection-item').forEach(item => {
            item.addEventListener('click', function() {
                const type = this.getAttribute('data-type');
                const value = this.getAttribute('data-value');
                if (type === 'room') {
                    document.querySelectorAll('.selection-item[data-type="room"]').forEach(room => {
                        room.classList.remove('selected');
                    });
                    this.classList.add('selected');
                    selectedRoom = value;
                    document.getElementById('selectedRoomId').value = value;
                    roomCounter.textContent = 'Selected: 1/1';
                } else if (type === 'teacher') {
                    document.querySelectorAll('.selection-item[data-type="teacher"]').forEach(teacher => {
                        teacher.classList.remove('selected');
                    });
                    this.classList.add('selected');
                    selectedTeacher = value;
                    document.getElementById('selectedTeacherId').value = value;
                    teacherCounter.textContent = 'Selected: 1/1';
                }
                updateSubmitButton();
            });
        });

        function updateSubmitButton() {
            if (selectedRoom && selectedTeacher) {
                saveButton.disabled = false;
                validationMessage.style.display = 'none';
            } else {
                saveButton.disabled = true;
                validationMessage.style.display = 'block';
            }
        }
        form.addEventListener('submit', function(e) {
            if (!selectedRoom || !selectedTeacher) {
                e.preventDefault();
                validationMessage.style.display = 'block';
                validationMessage.textContent = 'Please select both a room and a teacher to continue.';
            }
        });
    });
</script>
</body>
</html>
