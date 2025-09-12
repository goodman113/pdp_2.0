package org.example.pdp_2;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import lombok.SneakyThrows;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    @SneakyThrows
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
        request.getRequestDispatcher("/student_panel.jsp").forward(request,response);
    }
}