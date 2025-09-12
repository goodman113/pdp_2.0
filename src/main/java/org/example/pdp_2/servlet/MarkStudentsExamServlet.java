package org.example.pdp_2.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.repository.ExamDAO;
import org.example.pdp_2.repository.ExamResultDAO;
import org.example.pdp_2.repository.GroupDAO;
import org.example.pdp_2.repository.UserDAO;
import org.example.pdp_2.entity.Exam;
import org.example.pdp_2.entity.ExamResult;
import org.example.pdp_2.entity.Group;
import org.example.pdp_2.entity.User;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import static org.example.pdp_2.repository.ExamResultDAO.getExamResultDAO;

@WebServlet("/markStudentsExam")
public class MarkStudentsExamServlet extends HttpServlet {
    private final GroupDAO groupDAO = GroupDAO.getGroupDAO();
    private final UserDAO userDAO = UserDAO.getUserDAO();
    private final ExamDAO examDAO = ExamDAO.getInstance();
    private final ExamResultDAO examResultDAO = getExamResultDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Group group = (Group) req.getSession().getAttribute("group");
        if (group == null) {
            resp.sendRedirect("/show-groups.jsp");
            return;
        }

        // get latest exam for this group
        Optional<Exam> examOpt = examDAO.getLatestExamByGroup(group.getId(), group.getModuleNumber());
        if (examOpt.isEmpty()) {

            req.setAttribute("exam", null);
            req.setAttribute("error", "No exam found for this group.");
            req.getRequestDispatcher("/markStudentsExam.jsp").forward(req, resp);
            return;
        }
        Exam exam = examOpt.get();

        // get all students in group
        List<User> students = group.getStudents();

        // ensure each student has an ExamResult
        for (User student : students) {
            if (!examResultDAO.existsByExamAndStudent(exam.getId(), student.getId())) {
                ExamResult er = new ExamResult();
                er.setExam(exam);
                er.setStudent(student);
                er.setStudentMark(null); // mark not given yet
                examResultDAO.saveExamResult(er);
            }
        }

        List<ExamResult> examResults = examResultDAO.getExamResultsByExamId(exam.getId());
        req.setAttribute("exam", exam);
        req.setAttribute("examResults", examResults);
        req.getRequestDispatcher("/markStudentsExam.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer examId = Integer.parseInt(req.getParameter("examId"));

        // loop over marks
        req.getParameterMap().forEach((key, value) -> {
            if (key.startsWith("student_")) {
                Integer studentId = Integer.parseInt(key.replace("student_", ""));
                Integer mark = Integer.parseInt(value[0]);
                examResultDAO.updateMark(examId, studentId, mark);
            }
        });
        Optional<Exam> examById = examDAO.getExamById(examId);
        if (examById.isEmpty()){
            resp.sendRedirect("/show-groups.jsp");
            return;
        }
        Exam exam = examById.get();
        exam.setIsCompleted(true);
        examDAO.saveExam(exam);
        req.setAttribute("message", "Marks saved successfully.");
        req.getRequestDispatcher("/teacher-panel.jsp").forward(req, resp);
    }
}

