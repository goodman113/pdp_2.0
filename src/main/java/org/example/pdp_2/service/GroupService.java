package org.example.pdp_2.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.example.pdp_2.entity.Group;
import org.example.pdp_2.entity.Room;
import org.example.pdp_2.entity.User;
import org.example.pdp_2.entity.enums.Days;
import org.example.pdp_2.repository.GroupDAO;
import org.example.pdp_2.repository.RoomDAO;
import org.example.pdp_2.repository.UserDAO;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class GroupService {
    RoomDAO roomDAO = RoomDAO.getInstance();
    UserDAO userDAO = UserDAO.getInstance();
    GroupDAO groupDAO = GroupDAO.getInstance();
    public void showGroups(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Group>groups = groupDAO.findAll();
        req.setAttribute("groups",groups);
        req.getRequestDispatcher("/groups.jsp").forward(req,resp);
    }

    public void deleteStudentFromGroup(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer studentId = Integer.parseInt(req.getParameter("studentId"));
        Integer groupId = Integer.parseInt(req.getParameter("groupId"));
        userDAO.deleteUserFromGroup(studentId, groupId);
        resp.sendRedirect(req.getContextPath() + "/students?id=" + groupId);
    }

    @SneakyThrows
    public void createGroup(HttpServletRequest req, HttpServletResponse resp) {
        Group group = new Group();
        LocalTime endTime = LocalTime.parse(req.getParameter("endTime"));
        LocalTime startTime = LocalTime.parse(req.getParameter("startTime"));
        Days days = Days.valueOf(req.getParameter("days"));
        group.setGroupName(req.getParameter("groupName"));
        group.setLessonDays(days);
        group.setStartTime(startTime);
        group.setEndTime(endTime);
        group.setModuleNumber(1);
        group.setIsActive(true);
        List<Room> rooms = groupDAO.getAvailableRooms(days, startTime, endTime, group.getId());
        if (rooms.isEmpty()) {
            req.setAttribute("message", "Rooms not available");
            req.getRequestDispatcher("errors.jsp").forward(req,resp);
            return;
        }
        List<User> teachers = userDAO.getAvailableTeachers(days, startTime, endTime, group.getId());
        if (teachers.isEmpty()) {
            req.setAttribute("message", "Teachers not available");
            req.getRequestDispatcher("errors.jsp").forward(req,resp);
            return;
        }
        groupDAO.save(group);
        req.setAttribute("group", group);
        req.setAttribute("teachers", teachers);
        req.setAttribute("rooms", rooms);
        req.getRequestDispatcher("/chooseRoomAndTeacher.jsp").forward(req,resp);
    }

    public void prepareEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Group group = groupDAO.findById(Integer.valueOf(req.getParameter("id"))).orElseThrow();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        req.setAttribute("module", group.getModuleNumber());
        req.setAttribute("startTime", group.getStartTime().format(formatter));
        req.setAttribute("endTime", group.getEndTime().format(formatter));
        req.setAttribute("group", group);
        req.setAttribute("days", Days.values());

        req.getRequestDispatcher("/edit-group.jsp").forward(req, resp);
    }


    @SneakyThrows
    public void updateGroup(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        Group group = groupDAO.findById(Integer.valueOf(req.getParameter("id"))).orElseThrow();
        group.setGroupName(req.getParameter("groupName"));
        LocalTime startTime = LocalTime.parse(req.getParameter("startTime"), formatter);
        LocalTime endTime = LocalTime.parse(req.getParameter("endTime"), formatter);
        group.setStartTime(startTime);
        group.setEndTime(endTime);
        group.setModuleNumber(Integer.valueOf(req.getParameter("module")));
        Days days = Days.valueOf(req.getParameter("day"));
        group.setLessonDays(days);
        List<Room> rooms = groupDAO.getAvailableRooms(days, startTime, endTime, group.getId());
        if (!startTime.isBefore(endTime)) {
            req.setAttribute("message", "Start time must be before end time");
            req.getRequestDispatcher("errors.jsp").forward(req, resp);
            return;
        }
        if (rooms.isEmpty()) {
            req.setAttribute("message", "Rooms not available");
            req.getRequestDispatcher("errors.jsp").forward(req, resp);
            return;
        }
        List<User> teachers = userDAO.getAvailableTeachers(days, startTime, endTime, group.getId());
        if (teachers.isEmpty()) {
            req.setAttribute("message", "Teachers not available");
            req.getRequestDispatcher("errors.jsp").forward(req, resp);
            return;
        }
        groupDAO.save(group);
        req.setAttribute("group", group);
        req.setAttribute("teachers", teachers);
        req.setAttribute("rooms", rooms);
        req.getRequestDispatcher("/editRoomAndTeacher.jsp").forward(req, resp);
    }

    public void saveGroup(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer teacherId = Integer.valueOf(req.getParameter("teacherId"));
        User teacher = userDAO.findById(teacherId).orElseThrow();
        Integer roomId = Integer.valueOf(req.getParameter("roomId"));
        Room room = roomDAO.findById(roomId).orElseThrow();
        Integer groupId = Integer.valueOf(req.getParameter("groupId"));
        Group group = groupDAO.findById(groupId).orElseThrow();
        group.setTeacher(teacher);
        group.setRoom(room);
        groupDAO.save(group);
        resp.sendRedirect("group?success=teacherAdded");
    }
    private static GroupService instance;
    public static GroupService getInstance() {
        if (instance == null) {
            instance = new GroupService();
        }
        return instance;
    }

    public void handleAddStudents(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String groupId = req.getParameter("groupId");
        String[] selectedStudentIds = req.getParameterValues("selectedStudents");
        if (groupId == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Group ID is required");
            return;
        }
        if (selectedStudentIds == null || selectedStudentIds.length == 0) {
            req.setAttribute("error", "Please select at least one student");
            showAddStudentsForm(req, resp, groupId);
            return;
        }
        try {
            Integer id = Integer.parseInt(groupId);
            List<Integer> studentIds = new ArrayList<>();
            for (String studentId : selectedStudentIds) {
                studentIds.add(Integer.parseInt(studentId));
            }
            groupDAO.addStudentsByIds(id, studentIds);
            resp.sendRedirect("/group?id=" + groupId + "&success=studentsAdded");
        } catch (RuntimeException e) {
            req.setAttribute("error", e.getMessage());
            showAddStudentsForm(req, resp, groupId);
        } catch (Exception e) {
            req.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            showAddStudentsForm(req, resp, groupId);
        }
    }

    public void showAddStudentsForm(HttpServletRequest req, HttpServletResponse resp, String groupId) throws ServletException, IOException {
        Integer id = Integer.parseInt(groupId);
        Optional<Group> group1 = groupDAO.getGroupById(id);
        Group group = group1.get();
        if (group != null) {
            List<User> availableStudents = userDAO.getAvailableStudents(id);
            int currentStudents = group.getStudents() != null ? group.getStudents().size() : 0;
            int roomCapacity = group.getRoom().getCapacity();
            int remainingCapacity = roomCapacity - currentStudents;
            req.setAttribute("group", group);
            req.setAttribute("availableStudents", availableStudents);
            req.setAttribute("remainingCapacity", remainingCapacity);
            req.setAttribute("currentStudents", currentStudents);
            req.setAttribute("roomCapacity", roomCapacity);
            req.getRequestDispatcher("/addStudents.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Group not found");
        }
    }

    public void changeStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer groupId = Integer.valueOf(req.getParameter("id"));
        groupDAO.changeStatusGroup(groupId);
        resp.sendRedirect("/group");
    }
}
