package org.example.pdp_2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.service.GroupService;

import java.io.IOException;

@WebServlet("/group")
public class groupController extends HttpServlet {
    GroupService groupService = GroupService.getInstance();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        groupService.showGroups(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String teacherId = req.getParameter("teacherId");
        if (teacherId != null && !teacherId.isEmpty()) {
            groupService.saveGroup(req,resp);
        }
        else {
            groupService.createGroup(req, resp);
        }
    }
}
