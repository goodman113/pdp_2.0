package org.example.pdp_2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.service.GroupService;

import java.io.IOException;

@WebServlet("/edit-group")
public class editGroupController extends HttpServlet {
    GroupService groupService = GroupService.getInstance();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("disable".equals(action)) {
            groupService.changeStatus(req,resp);
        }
        else {
            groupService.prepareEditForm(req,resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        groupService.updateGroup(req,resp);
    }
}
