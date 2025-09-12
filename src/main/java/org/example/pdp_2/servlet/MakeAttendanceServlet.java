package org.example.pdp_2.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.repository.*;
import org.example.pdp_2.entity.*;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/makeAttendance")
public class MakeAttendanceServlet extends HttpServlet {
    ExamDAO examDAO = ExamDAO.getInstance();
    AttendanceDAO attendanceDAO = AttendanceDAO.getAttendanceDAO();
    LessonDAO lessonDAO = LessonDAO.getInstance();
    UserDAO userDAO = UserDAO.getUserDAO();
    GroupDAO groupDAO = GroupDAO.getGroupDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer lessonId = Integer.parseInt(req.getParameter("lessonId"));
        Lesson lesson = lessonDAO.getLessonById(lessonId).orElseThrow();

        // create attendance record for this lesson
        Attendance attendance = new Attendance();
        attendance.setLesson(lesson);
        attendanceDAO.saveAttendance(attendance);

        // all students
        List<User> students = lesson.getGroup().getStudents();

        // students marked present
        String[] presentIds = req.getParameterValues("present");
        Set<Integer> presentSet = new HashSet<>();
        if (presentIds != null) {
            for (String id : presentIds) {
                presentSet.add(Integer.parseInt(id));
            }
        }

        // save Student_Attendance
        for (User s : students) {
            Student_Attendance sa = new Student_Attendance();
            sa.setStudent(s);
            sa.setAttendance(attendance);
            sa.setIsAttended(presentSet.contains(s.getId()));
            attendanceDAO.saveStudentAttendance(sa);
        }

        // mark lesson as completed
        lesson.setIsCompleted(true);lessonDAO.saveLesson(lesson);

// check if this was the 12th lesson of the module
        if (lesson.getLessonNumber() == 12) {
            // increment group module
            var group = lesson.getGroup();
            group.setModuleNumber(group.getModuleNumber() + 1);
            groupDAO.saveGroup(group);

            // create Exam
            Exam exam = new Exam();
            exam.setGroup(group);
            exam.setIsCompleted(false);
            exam.setModuleNumber(group.getModuleNumber());
            examDAO.saveExam(exam);
        }
        resp.sendRedirect("/startLesson");
    }
}