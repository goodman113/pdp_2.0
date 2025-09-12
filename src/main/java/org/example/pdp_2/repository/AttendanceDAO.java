package org.example.pdp_2.repository;

import jakarta.persistence.EntityManager;
import org.example.pdp_2.entity.Attendance;
import org.example.pdp_2.entity.Student_Attendance;

import java.util.List;

import static org.example.pdp_2.repository.EntityManagerDAO.getEntityManager;

public class AttendanceDAO {
    static AttendanceDAO attendanceDAO = null;
    public static AttendanceDAO getAttendanceDAO() {
        if (attendanceDAO == null) {
            attendanceDAO = new AttendanceDAO();
        }
        return attendanceDAO;
    }
    private AttendanceDAO(){

    }

    public List<Student_Attendance> getStudentAttendancesByLessonId(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("""
            select sa
            from Student_Attendance sa
            join fetch sa.student s
            join sa.attendance a
            where a.lesson.id = :lessonId
            """, Student_Attendance.class)
                    .setParameter("lessonId", id)
                    .getResultList();
        } finally {
            em.close(); // very important!
        }
    }


    public void saveAttendance(Attendance attendance) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(attendance);
        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public void saveStudentAttendance(Student_Attendance sa) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(sa);
        entityManager.getTransaction().commit();
        entityManager.close();
    }
}
