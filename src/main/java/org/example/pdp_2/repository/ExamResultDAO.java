package org.example.pdp_2.repository;

import jakarta.persistence.EntityManager;
import org.example.pdp_2.entity.ExamResult;

import java.util.List;

import static org.example.pdp_2.repository.EntityManagerDAO.getEntityManager;

public class ExamResultDAO {
    static ExamResultDAO examResultDAO = null;
    public static ExamResultDAO getExamResultDAO() {
        if (examResultDAO == null) {
            examResultDAO = new ExamResultDAO();
        }
        return examResultDAO;
    }
    private  ExamResultDAO() {}

    public void saveExamResult(ExamResult er) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        if (er.getId() == null)
            entityManager.persist(er);
        else
            entityManager.merge(er);
        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public List<ExamResult> getExamResultsByExamId(Integer id) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        List<ExamResult> examResults = entityManager.createQuery("select e from ExamResult e where e.exam.id = :examId", ExamResult.class)
                .setParameter("examId", id)
                .getResultList();
        entityManager.close();
        return examResults;
    }

    public boolean existsByExamAndStudent(Integer examId, Integer studentId) {
        EntityManager em = getEntityManager();
        Long count = em.createQuery(
                        "SELECT COUNT(er) FROM ExamResult er WHERE er.exam.id = :examId AND er.student.id = :studentId",
                        Long.class)
                .setParameter("examId", examId)
                .setParameter("studentId", studentId)
                .getSingleResult();
        em.close();
        return count > 0;
    }

    public void updateMark(Integer examId, Integer studentId, Integer mark) {
        EntityManager em = getEntityManager();
        em.getTransaction().begin();
        ExamResult er = em.createQuery(
                        "SELECT er FROM ExamResult er WHERE er.exam.id = :examId AND er.student.id = :studentId",
                        ExamResult.class)
                .setParameter("examId", examId)
                .setParameter("studentId", studentId)
                .getSingleResult();
        er.setStudentMark(mark);
        em.merge(er);
        em.getTransaction().commit();
        em.close();
    }

    public List<ExamResult> getExamResultsByGroupId(Integer id) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        List<ExamResult> examResults = entityManager.createQuery("select e from ExamResult e where e.exam.group.id = :groupId order by e.id desc", ExamResult.class)
                .setParameter("groupId", id)
                .getResultList();
        entityManager.close();
        return examResults;
    }
}
