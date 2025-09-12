package org.example.pdp_2.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.repository.GroupDAO;
import org.example.pdp_2.entity.Group;
import org.example.pdp_2.entity.User;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/showStudents")
public class ShowStudents extends HttpServlet {
    GroupDAO groupDAO = GroupDAO.getGroupDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user =(User)req.getSession().getAttribute("user");
        int groupId = Integer.parseInt(req.getParameter("groupId"));
        Optional<Group> optionalGroup = groupDAO.getGroupById(groupId);
        if (optionalGroup.isEmpty()){
            req.setAttribute("error", "group not found");
            List<Group> groups = groupDAO
                    .getGroups(user.getId());
            System.out.println(groups);
            req.setAttribute("groups", groups);
            req.getRequestDispatcher("/teacher/show-groups.jsp").forward(req, resp);
            return;
        }
        Group group = optionalGroup.get();
        System.out.println(group.getStudents());
        req.setAttribute("students", group.getStudents());
        req.getRequestDispatcher("/teacher/show-group-students.jsp").forward(req, resp);
    }
}
