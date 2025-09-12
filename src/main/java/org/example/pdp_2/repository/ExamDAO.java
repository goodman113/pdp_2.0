package org.example.pdp_2.repository;

import jakarta.persistence.EntityManager;
import org.example.pdp_2.entity.Exam;

import java.util.Optional;

import static org.example.pdp_2.repository.EntityManagerDAO.getEntityManager;

public class ExamDAO {
    static ExamDAO examDAO = null;
    public static ExamDAO getInstance() {
        if (examDAO == null) {
            examDAO = new ExamDAO();
        }
        return examDAO;
    }
    private ExamDAO() {}

    public Optional<Exam> getLatestExamByGroup(Integer groupId, Integer moduleNumber) {
        EntityManager em = getEntityManager();
        Exam exam = em.createQuery(
                        "SELECT e FROM Exam e WHERE e.group.id = :groupId AND e.moduleNumber = :moduleNumber and e.isCompleted=false ORDER BY e.id DESC",
                        Exam.class)
                .setParameter("groupId", groupId)
                .setParameter("moduleNumber", moduleNumber)
                .setMaxResults(1)
                .getResultStream()
                .findFirst()
                .orElse(null);
        em.close();
        return Optional.ofNullable(exam);
    }

    public void saveExam(Exam exam) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        if (exam.getId()==null)
            entityManager.persist(exam);
        else
            entityManager.merge(exam);
        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public Optional<Exam> getExamById(Integer examId) {
        EntityManager entityManager = getEntityManager();
        Exam exam = entityManager.find(Exam.class, examId);
        entityManager.close();
        return Optional.ofNullable(exam);
    }
}
