package org.example.pdp_2.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.repository.UserDAO;
import org.example.pdp_2.entity.Student_Attendance;
import org.example.pdp_2.entity.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/seeMyAttendance")
public class seeMyAttendanceServlet extends HttpServlet {
    UserDAO userDAO = UserDAO.getUserDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        List<Student_Attendance> attendances = userDAO
                .getAttendanceByStudentId(user.getId());
        req.setAttribute("attendances", attendances);
        req.setAttribute("user", user);
        req.getRequestDispatcher("/seeMyAttendance.jsp").forward(req, resp);
    }
}
