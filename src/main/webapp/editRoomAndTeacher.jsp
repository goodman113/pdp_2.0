<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit</title>
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

        .edit-header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            border: 1px solid rgba(96, 165, 250, 0.2);
            border-left: 4px solid #60a5fa;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        .edit-header h2 {
            color: #60a5fa;
            margin-bottom: 5px;
            font-size: 1.8rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .edit-header p {
            color: #94a3b8;
            font-size: 0.95em;
        }

        .selection-group {
            margin-bottom: 30px;
            position: relative;
        }

        .section-title {
            position: relative;
            display: inline-block;
        }

        .section-title h3 {
            margin-bottom: 15px;
            color: #f1f5f9;
            border-bottom: 2px solid #3b82f6;
            padding-bottom: 5px;
            font-size: 1.2rem;
        }

        .selection-item {
            display: block;
            width: 100%;
            padding: 12px 15px;
            margin: 8px 0;
            border: 2px solid rgba(71, 85, 105, 0.5);
            border-radius: 8px;
            background: rgba(51, 65, 85, 0.3);
            cursor: pointer;
            transition: all 0.3s ease;
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
            width: 100%;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
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
        }

        .selection-counter {
            background: rgba(239, 68, 68, 0.8);
            color: white;
            border-radius: 12px;
            padding: 4px 8px;
            font-size: 12px;
            font-weight: bold;
            min-width: 60px;
            text-align: center;
            margin-top: 10px;
            display: inline-block;
            backdrop-filter: blur(5px);
        }

        .changes-detected {
            background: rgba(251, 191, 36, 0.1);
            border: 1px solid rgba(251, 191, 36, 0.4);
            color: #fbbf24;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
            backdrop-filter: blur(5px);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="edit-header">
        <h2>Edit group</h2>
    </div>

    <form id="selectionForm" method="post" action="/group">
        <input type="hidden" name="groupId" value="${group.id}">

        <div class="selection-group">
            <h3>Choose the room:</h3>
            <div id="roomCounter" class="selection-counter"></div>
            <div id="roomSelection">
                <c:forEach var="room" items="${rooms}" varStatus="status">
                    <div class="selection-item${room.id == group.room.id ? ' selected' : ''}"
                         data-type="room"
                         data-value="${room.id}">
                            ${room.number} (capacity: ${room.capacity})
                    </div>
                </c:forEach>
            </div>
            <input type="hidden" id="selectedRoomId" name="roomId" value="${group.room.id}">
        </div>

        <div class="selection-group">
            <h3>Choose the teacher:</h3>
            <div id="teacherCounter" class="selection-counter"></div>
            <div id="teacherSelection">
                <c:forEach var="teacher" items="${teachers}" varStatus="status">
                    <div class="selection-item${teacher.id == group.teacher.id ? ' selected' : ''}"
                         data-type="teacher"
                         data-value="${teacher.id}">
                            ${teacher.name} ${teacher.surname}
                    </div>
                </c:forEach>
            </div>
            <input type="hidden" id="selectedTeacherId" name="teacherId" value="${group.teacher.id}">
        </div>

        <button type="submit" class="save-button" id="saveButton">
            Next
        </button>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('selectionForm');
        const saveButton = document.getElementById('saveButton');
        const roomCounter = document.getElementById('roomCounter');
        const teacherCounter = document.getElementById('teacherCounter');

        let selectedRoom = document.getElementById('selectedRoomId').value || null;
        let selectedTeacher = document.getElementById('selectedTeacherId').value || null;

        const originalRoomId = "${group.room.id}";
        const originalTeacherId = "${group.teacher.id}";

        function updateCounters() {
            roomCounter.textContent = selectedRoom ? 'Selected: 1/1' : 'Selected: 0/1';
            teacherCounter.textContent = selectedTeacher ? 'Selected: 1/1' : 'Selected: 0/1';
        }

        function updateSubmitButton() {
            const hasChanges = selectedRoom !== originalRoomId || selectedTeacher !== originalTeacherId;

            if (selectedRoom && selectedTeacher) {
                saveButton.disabled = false;
                if (hasChanges) {
                    saveButton.style.backgroundColor = '#e67e22';
                    saveButton.textContent = 'Save updates';
                } else {
                    saveButton.style.backgroundColor = '#28a745';
                    saveButton.textContent = 'Next';
                }
            } else {
                saveButton.disabled = true;
                saveButton.style.backgroundColor = '#6c757d';
            }
        }

        updateCounters();
        updateSubmitButton();

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
                } else if (type === 'teacher') {
                    document.querySelectorAll('.selection-item[data-type="teacher"]').forEach(teacher => {
                        teacher.classList.remove('selected');
                    });
                    this.classList.add('selected');
                    selectedTeacher = value;
                    document.getElementById('selectedTeacherId').value = value;
                }

                updateCounters();
                updateSubmitButton();
            });
        });

        form.addEventListener('submit', function(e) {
            if (!selectedRoom || !selectedTeacher) {
                e.preventDefault();
                alert('Please choose the room and teacher');
            }
        });
    });
</script>
</body>
</html>
