package org.example.pdp_2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.pdp_2.service.GroupService;
import org.example.pdp_2.service.UserService;

import java.io.IOException;
@WebServlet("/students")
public class studentController extends HttpServlet {
    UserService userService = UserService.getInstance();
    GroupService groupService = GroupService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String studentId = req.getParameter("studentId");
        if (studentId != null && !studentId.isEmpty()) {
            groupService.deleteStudentFromGroup(req, resp);
        } else {
            userService.showStudents(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        groupService.handleAddStudents(req, resp);
    }
}
