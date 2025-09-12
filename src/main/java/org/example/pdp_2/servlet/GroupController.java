package org.example.pdp_2.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.example.pdp_2.repository.GroupDAO;
import org.example.pdp_2.entity.Group;
import org.example.pdp_2.entity.User;

import java.util.List;

@WebServlet("/groups")
public class GroupController extends HttpServlet {
    GroupDAO groupDAO = GroupDAO.getGroupDAO();
    @SneakyThrows
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        User user =(User)req.getSession().getAttribute("user");
        List<Group> groups = groupDAO
                .getGroups(user.getId());
        System.out.println(groups);
        req.setAttribute("groups", groups);
        req.getRequestDispatcher("/teacher/show-groups.jsp").forward(req, resp);
    }
}
