package org.example.pdp_2.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.repository.AttendanceDAO;
import org.example.pdp_2.repository.GroupDAO;
import org.example.pdp_2.repository.LessonDAO;
import org.example.pdp_2.entity.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;


@WebServlet("/startLesson")
public class StartLessonServlet extends HttpServlet {
    LessonDAO lessonDAO = LessonDAO.getInstance();
    AttendanceDAO attendanceDAO = AttendanceDAO.getAttendanceDAO();
    GroupDAO groupDAO = GroupDAO.getGroupDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Group group = (Group) req.getSession().getAttribute("group");
        if(group==null){
            req.getRequestDispatcher("/show-groups.jsp").forward(req,resp);
            return;
        }
        req.setAttribute("group",group);
        List<Lesson> lessons = groupDAO.getGroupsLessonsByGroupId(group.getId(), group.getModuleNumber());
        req.setAttribute("lessons",lessons);
        // build map: lessonId -> list of student attendances
        Map<Integer, List<Student_Attendance>> lessonAttendances = new HashMap<>();
        for (Lesson lesson : lessons) {
            List<Student_Attendance> saList = attendanceDAO.getStudentAttendancesByLessonId(lesson.getId());
            lessonAttendances.put(lesson.getId(), saList);
        }
        req.setAttribute("lessonAttendances", lessonAttendances);
        req.getRequestDispatcher("/showGroupLessons.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer groupId = Integer.parseInt(req.getParameter("groupId"));
        Integer lessonNumber = Integer.parseInt(req.getParameter("lessonNumber"));

        Optional<Group> groupById = groupDAO.getGroupById(groupId);
        if (groupById.isEmpty()) {
            req.getRequestDispatcher("/show-groups.jsp").forward(req, resp);
            return;
        }

        Group group = groupById.get();
        List<Lesson> lessons = groupDAO.getGroupsLessonsByGroupId(group.getId(), group.getModuleNumber());

        // block if there are uncompleted lessons
        for (Lesson l : lessons) {
            if (!l.getIsCompleted()) {
                req.setAttribute("error", "You have to complete the previous lesson first!");
                req.setAttribute("lessons", lessons);
                req.getRequestDispatcher("/showGroupLessons.jsp").forward(req, resp);
                return;
            }
        }
        User user = (User) req.getSession().getAttribute("user");

        Lesson newLesson = new Lesson();
        newLesson.setDate(LocalDate.now());
        newLesson.setGroup(group);
        newLesson.setIsCompleted(false);
        newLesson.setTeacher(user);
        newLesson.setModuleNumber(group.getModuleNumber());

// calculate next lessonNumber
        int nextLessonNumber = lessons.isEmpty()
                ? 1
                : lessons.get(lessons.size() - 1).getLessonNumber() + 1;

// if it’s greater than 12 → reset and increment module
        if (nextLessonNumber > 12) {
            nextLessonNumber = 1;
            group.setModuleNumber(group.getModuleNumber() + 1);
            groupDAO.saveGroup(group);
            newLesson.setModuleNumber(group.getModuleNumber());
        }

        newLesson.setLessonNumber(nextLessonNumber);

// save the new lesson
        lessonDAO.saveLesson(newLesson);

        List<Lesson> updatedLessons = groupDAO.getGroupsLessonsByGroupId(group.getId(), group.getModuleNumber());
        // forward to makeAttendance.jsp
        req.getSession().setAttribute("group", group);
        req.setAttribute("lessons", updatedLessons);
        req.setAttribute("lesson", newLesson);
        req.setAttribute("students", group.getStudents());
        req.getRequestDispatcher("/makeAttendance.jsp").forward(req, resp);
    }
}
