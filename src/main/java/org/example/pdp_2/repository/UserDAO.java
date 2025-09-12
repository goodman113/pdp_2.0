package org.example.pdp_2.repository;

import jakarta.persistence.EntityManager;
import org.example.pdp_2.entity.*;
import org.example.pdp_2.entity.enums.Days;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

import static org.example.pdp_2.repository.EntityManagerDAO.getEntityManager;

public class UserDAO {
    static UserDAO userDAO = null;
    public static UserDAO getUserDAO() {
        if (userDAO == null) {
            userDAO = new UserDAO();
        }
        return userDAO;
    }
    private UserDAO() {}

    public Optional<User> getUserByNumber(String number) {
        EntityManager entityManager = getEntityManager();
        try {
            return entityManager.createQuery(
                            "SELECT u FROM User u WHERE u.phoneNumber = :number", User.class)
                    .setParameter("number", number)
                    .getResultStream()
                    .findFirst();
        } finally {
            entityManager.close();
        }
    }

    public List<Lesson> getLessonsByUserID(Integer id) {

        EntityManager em = getEntityManager();
        return em.createQuery("""
            SELECT l 
            FROM Lesson l
            JOIN l.group g
            JOIN g.students s
            WHERE s.id = :studentId
            """, Lesson.class)
                .setParameter("studentId", id)
                .getResultList();
        }

    public List<ExamResult> getExamResultsByUserId(Integer id) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        List<ExamResult> examResults = entityManager.createQuery("select e from ExamResult e where e.student.id = :userId", ExamResult.class)
                .setParameter("userId", id)
                .getResultList();
        entityManager.close();
        return examResults;
    }

    public List<Student_Attendance> getAttendanceByStudentId(Integer id) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        List<Student_Attendance> attendances = entityManager.createQuery("select s from Student_Attendance s where s.student.id = :userId", Student_Attendance.class)
                .setParameter("userId", id)
                .getResultList();
        return attendances;
    }

    public void save(User user) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        if (user.getId() == null)
            entityManager.persist(user);
        else
            entityManager.merge(user);

        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public void deleteUserFromGroup(Integer studentId, Integer groupId) {
        EntityManager em = getEntityManager();
        em.getTransaction().begin();
        Group group = em.find(Group.class, groupId);
        User student = em.find(User.class, studentId);
        if (group != null && student != null) {
            group.getStudents().remove(student);
            em.merge(group);
        }
        em.getTransaction().commit();
        em.close();
    }

    public Optional<User> findById(Integer id) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        User user = entityManager.find(User.class, id);
        entityManager.getTransaction().commit();
        entityManager.close();
        return Optional.ofNullable(user);
    }

    public List<User> findAll() {
        EntityManager entityManager = getEntityManager();
        entityManager
                .getTransaction()
                .begin();
        List<User> selectPFromUser =
                entityManager
                        .createQuery("select p from User p order by p.id", User.class)
                        .getResultList();

        entityManager
                .getTransaction()
                .commit();

        entityManager
                .close();
        return selectPFromUser;
    }

    public List<User> groupStudents(Integer groupId) {
        EntityManager  entityManager = getEntityManager();
        return entityManager.createQuery(
                        "SELECT u FROM Group g JOIN g.students u WHERE g.id = :groupId", User.class)
                .setParameter("groupId", groupId)
                .getResultList();
    }

    public List<User> getAvailableTeachers(Days lessonDay, LocalTime start, LocalTime end, Integer groupId) {
        EntityManager entityManager = getEntityManager();

        String jpql = """
        SELECT u FROM User u
        WHERE u.role = 'TEACHER'
          AND NOT EXISTS (
              SELECT g FROM Group g
              WHERE g.teacher = u
                AND g.lessonDays = :day
                AND g.id <> :groupId
                AND NOT (
                    :end <= g.startTime OR
                    :start >= g.endTime
                )
          )
        """;

        return entityManager.createQuery(jpql, User.class)
                .setParameter("day", lessonDay)
                .setParameter("start", start)
                .setParameter("end", end)
                .setParameter("groupId", groupId == null ? -1 : groupId)
                .getResultList();
    }

    public List<User> getAvailableStudents(Integer groupId) {
        EntityManager entityManager = getEntityManager();

        String jpql = """
        SELECT u FROM User u
        WHERE u.role = 'STUDENT'
          AND u.is_Active = true
          AND NOT EXISTS (
              SELECT s FROM Group g JOIN g.students s
              WHERE g.id = :groupId AND s.id = u.id
          )
        ORDER BY u.surname, u.name
        """;

        List<User> result = entityManager.createQuery(jpql, User.class)
                .setParameter("groupId", groupId)
                .getResultList();

        entityManager.close();
        return result;
    }

    public static UserDAO getInstance() {
        if (userDAO == null) {
            userDAO = new UserDAO();
        }
        return userDAO;
    }
}
