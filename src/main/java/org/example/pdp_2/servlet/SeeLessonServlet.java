package org.example.pdp_2.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.repository.UserDAO;
import org.example.pdp_2.entity.Lesson;
import org.example.pdp_2.entity.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/seeLessons")
public class SeeLessonServlet extends HttpServlet {
    UserDAO userDAO = UserDAO.getUserDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        req.getSession().setAttribute("user", user);
        List<Lesson> lessons = userDAO.getLessonsByUserID(user.getId());
        req.setAttribute("lessons", lessons);
        req.getRequestDispatcher("/seeLessons.jsp").forward(req, resp);
    }
}
