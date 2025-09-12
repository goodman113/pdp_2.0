package org.example.pdp_2.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.example.pdp_2.repository.GroupDAO;
import org.example.pdp_2.repository.UserDAO;
import org.example.pdp_2.entity.Group;
import org.example.pdp_2.entity.User;
import org.example.pdp_2.entity.enums.Role;

import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

@WebServlet("/signin")
public class SignInServlet extends HttpServlet {
    GroupDAO groupDAO = GroupDAO.getGroupDAO();
    UserDAO userDAO = UserDAO.getUserDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/signin.jsp").forward(req,resp);
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String number = req.getParameter("number");
        String password = req.getParameter("password");
        Optional<User> userByNumber = userDAO.getUserByNumber(number);
        if (userByNumber.isEmpty()) {
            req.setAttribute("message","Number not found. Please try again");
            req.getRequestDispatcher("/signin.jsp").forward(req, resp);
            return;
        }
        User user = userByNumber.get();
        String uAndp = user.getPhoneNumber() + ":" + user.getPassword();
        String encodedIdentity = new String(Base64.getEncoder().encode(uAndp.getBytes()));
        resp.addCookie(new Cookie("identity", encodedIdentity));

        if (password.equals(user.getPassword())) {
            req.getSession().setAttribute("user", user);
            if (user.getRole() == Role.ADMIN) {
                req.getRequestDispatcher("/admin.jsp").forward(req, resp);
                return;
            }
            if (user.getRole()==Role.STUDENT) {
                req.getRequestDispatcher("/student_panel.jsp").forward(req, resp);
                return;
            }
            if(user.getRole()==Role.TEACHER){
                List<Group> groups = groupDAO.getGroups(user.getId());
                req.getSession().setAttribute("groups", groups);
                req.getRequestDispatcher("/show-groups.jsp").forward(req, resp);
            }
        }else {
            req.setAttribute("message","Password miss match. Please try again");
            resp.sendRedirect("/signin.jsp");
        }
    }
}
