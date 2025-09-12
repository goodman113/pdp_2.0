//package org.example.pdp_2.myFilter;
//
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.Cookie;
//import jakarta.servlet.http.HttpServletRequest;
//import org.example.pdp_2.DAO.GroupDAO;
//import org.example.pdp_2.entity.Group;
//import org.example.pdp_2.entity.User;
//import org.example.pdp_2.entity.enums.Role;
//import org.example.pdp_2.util.Utils;
//
//import java.io.IOException;
//import java.util.List;
//import java.util.Optional;
//
//
//@WebFilter("/*")
//public class MyFilter implements Filter {
//    GroupDAO groupDAO = GroupDAO.getGroupDAO();
//    @Override
//    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
//            throws IOException, ServletException {
//
//        HttpServletRequest request = (HttpServletRequest) servletRequest;
//        String path = request.getServletPath();
//        System.out.println("Path: " + path);
//
////        if (path.endsWith(".jsp")) {
////            request.setAttribute("message", "You cannot open .jsp pages directly from browser");
////            request.getRequestDispatcher("errors.jsp").forward(request, servletResponse);
////            return;
////        }
//
//        User user = (User) request.getSession().getAttribute("user");
//
//        if (user == null) {
//            Cookie[] cookies = request.getCookies();
//            if (cookies != null) {
//                Optional<User> userFromCookie = Utils.getUserFromCookie(cookies);
//                if (userFromCookie.isPresent()) {
//                    user = userFromCookie.get();
//                    request.getSession().setAttribute("user", user);
//                }
//            }
//        }
//
//        if (user != null) {
//            if (path.equals("/start-lesson")) {
//                if (user != null && user.getRole() == Role.TEACHER) {
//                    filterChain.doFilter(request, servletResponse); // allow
//                } else {
//                    request.setAttribute("message", "Only teachers can start a lesson");
//                    request.getRequestDispatcher("errors.jsp").forward(request, servletResponse);
//                }
//                return;
//            }
//            if (path.equals("/") || path.contains("sign") || path.equals("/home")) {
//                switch (user.getRole()) {
//                    case ADMIN -> request.getRequestDispatcher("/admin_panel").forward(request, servletResponse);
//                    case STUDENT -> request.getRequestDispatcher("/student_panel").forward(request, servletResponse);
//                    case TEACHER -> {
//
//                        List<Group> groups = groupDAO.getGroups(user.getId());
//                        request.setAttribute("groups", groups);
//                        request.getRequestDispatcher("/show-groups.jsp").forward(request, servletResponse);
//                    }
//                }
//                return;
//            }
//        }
//
//        if (user == null && !path.equals("/") && !path.contains("sign")) {
//            request.setAttribute("message", "Please login first");
//            request.getRequestDispatcher("errors.jsp").forward(request, servletResponse);
//            return;
//        }
//
//        filterChain.doFilter(request, servletResponse);
//    }
//}
//
