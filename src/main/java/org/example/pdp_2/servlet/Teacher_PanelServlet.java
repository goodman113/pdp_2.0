package org.example.pdp_2.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.repository.GroupDAO;
import org.example.pdp_2.entity.Group;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/teacher-panel")
public class Teacher_PanelServlet extends HttpServlet {
    GroupDAO groupDAO = GroupDAO.getGroupDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int groupId = Integer.parseInt(req.getParameter("groupId"));
        Optional<Group> groupById = groupDAO
                        .getGroupById(groupId);
        if (groupById.isEmpty()){
            req.setAttribute("error", "group not found");
            req.getRequestDispatcher("/show-groups.jsp").forward(req, resp);
            return;
        }
        Group group = groupById.get();
        req.getSession().setAttribute("group",group);
        req.getRequestDispatcher("/teacher-panel.jsp").forward(req, resp);
    }
}
