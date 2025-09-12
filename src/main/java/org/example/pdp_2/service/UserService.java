package org.example.pdp_2.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.entity.User;
import org.example.pdp_2.entity.enums.Role;
import org.example.pdp_2.repository.UserDAO;

import java.io.IOException;
import java.util.List;

public class UserService {
    UserDAO userDAO = UserDAO.getInstance();
    public void createUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        user.setName(req.getParameter("name"));
        user.setSurname(req.getParameter("surname"));
        user.setPhoneNumber(req.getParameter("phoneNumber"));
        user.setPassword(req.getParameter("password"));
        user.setRole(Role.valueOf(req.getParameter("role")));
        user.setIs_Active(true);
        userDAO.save(user);
        resp.sendRedirect("/users");
    }

    public void showUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = userDAO.findAll();
        req.setAttribute("users",users);
        req.setAttribute("roles", Role.values());
        req.getRequestDispatcher("/users.jsp").forward(req,resp);
    }

    public void showStudents(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer id = Integer.parseInt(req.getParameter("id"));
        List<User> students = userDAO.groupStudents(id);
        req.setAttribute("groupId",id);
        req.setAttribute("students",students);
        req.getRequestDispatcher("/students.jsp").forward(req,resp);
    }

    public void prepareEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer id = Integer.parseInt(req.getParameter("id"));
        User user = userDAO.findById(id).orElseThrow();
        req.setAttribute("user", user);
        req.setAttribute("roles", Role.values());
        req.getRequestDispatcher("/edit-user.jsp").forward(req, resp);
    }

    public void updateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = new User();
        user.setId(Integer.valueOf(req.getParameter("id")));
        user.setName(req.getParameter("name"));
        user.setSurname(req.getParameter("surname"));
        user.setPhoneNumber(req.getParameter("phoneNumber"));
        user.setPassword(req.getParameter("password"));
        user.setRole(Role.valueOf(req.getParameter("role")));
        user.setIs_Active(true);
        userDAO.save(user);
        resp.sendRedirect("/users");
    }

    private static UserService instance;
    public static UserService getInstance() {
        if (instance == null) {
            instance = new UserService();
        }
        return instance;
    }
}
