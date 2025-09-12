package org.example.pdp_2.repository;

import jakarta.persistence.EntityManager;
import org.example.pdp_2.entity.Lesson;

import java.util.Optional;

import static org.example.pdp_2.repository.EntityManagerDAO.getEntityManager;

public class LessonDAO {
    static LessonDAO lessonDAO = null;
    public static LessonDAO getInstance() {
        if (lessonDAO == null) {
            lessonDAO = new LessonDAO();
        }
        return lessonDAO;
    }

    public void saveLesson(Lesson lesson) {
        EntityManager entityManager =
                getEntityManager();
        entityManager.getTransaction().begin();
        if (lesson.getId()==null)
            entityManager.persist(lesson);
        else
            entityManager.merge(lesson);
        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public Optional<Lesson> getLessonById(Integer lessonId) {
        EntityManager entityManager =
                getEntityManager();
        Lesson lesson = entityManager.find(Lesson.class, lessonId);
        return Optional.ofNullable(lesson);
    }
}
