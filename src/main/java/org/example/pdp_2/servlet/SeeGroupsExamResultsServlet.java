package org.example.pdp_2.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.repository.ExamResultDAO;
import org.example.pdp_2.entity.ExamResult;
import org.example.pdp_2.entity.Group;

import java.io.IOException;
import java.util.List;

@WebServlet("/seeGroupsExamResults")
public class SeeGroupsExamResultsServlet extends HttpServlet {
    ExamResultDAO examResultDAO = ExamResultDAO.getExamResultDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Group group = (Group) req.getSession().getAttribute("group");
        List<ExamResult> examResultsByGroupId = examResultDAO.getExamResultsByGroupId(group.getId());
        req.setAttribute("examResults", examResultsByGroupId);
        req.getRequestDispatcher("/seeGroupsExamResults.jsp").forward(req, resp);
    }
}
