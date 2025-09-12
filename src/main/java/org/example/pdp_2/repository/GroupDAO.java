package org.example.pdp_2.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import org.example.pdp_2.entity.Group;
import org.example.pdp_2.entity.Lesson;
import org.example.pdp_2.entity.Room;
import org.example.pdp_2.entity.User;
import org.example.pdp_2.entity.enums.Days;
import org.example.pdp_2.entity.enums.Role;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.example.pdp_2.repository.EntityManagerDAO.getEntityManager;

public class GroupDAO {

    static GroupDAO groupDAO;
    public static GroupDAO getGroupDAO() {
        if (groupDAO == null) {
            groupDAO = new GroupDAO();
        }
        return groupDAO;
    }

    public List<Group> getGroups(int teacherId) {
        EntityManager entityManager = getEntityManager();
        List<Group> teacherId1 = entityManager.createQuery("SELECT g FROM Group g WHERE g.teacher.id = :teacherId order by  g.id", Group.class)
                .setParameter("teacherId", teacherId)
                .getResultList();
        entityManager.close();
        return teacherId1;
    }

    public Optional<Group> getUserGroup(int userId){
        EntityManager entityManager = getEntityManager();
        Query nativeQuery = entityManager.createNativeQuery("select * from groups where id (select id from group_users where student_id = %d)".formatted(userId));
        Group group = (Group) nativeQuery.getSingleResult();
        entityManager.close();
        return Optional.ofNullable(group);
    }
    public Optional<Group> getGroupById(int groupId){
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        Group group = entityManager.find(Group.class, groupId);
        group.getStudents().size();
        group.setStudents(new ArrayList<>(group.getStudents()));
        entityManager.getTransaction().commit();
        entityManager.close();
        return Optional.of(group);
    }

    public List<Lesson> getGroupsLessonsByGroupId(Integer id, Integer moduleNumber) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        List<Lesson> lessons = entityManager.createQuery("SELECT l FROM Lesson l WHERE l.group.id = :group_id and l.moduleNumber= :moduleNumber order by lessonNumber ", Lesson.class)
                .setParameter("group_id", id)
                .setParameter("moduleNumber", moduleNumber)
                .getResultList();
        entityManager.getTransaction().commit();
        entityManager.close();
        return lessons;
    }

    public void saveGroup(Group group) {
        EntityManager entityManager = getEntityManager();;
        entityManager.getTransaction().begin();
        if (group.getId()==null)
            entityManager.persist(group);
        else
            entityManager.merge(group);
        entityManager.getTransaction().commit();
        entityManager.close();
    }
    public void save(Group group) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        if (group.getId() == null)
            entityManager.persist(group);
        else
            entityManager.merge(group);

        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public void changeStatusGroup(Integer groupId) {
        EntityManager em = getEntityManager();
        em.getTransaction().begin();
        Group group = em.find(Group.class, groupId);
        if (group == null) {
            throw new IllegalArgumentException("Group with id " + groupId + " not found");
        }
        group.setIsActive(!group.getIsActive());
        em.merge(group);
        em.getTransaction().commit();
        em.close();
    }

    public Optional<Group> findById(Integer id) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        Group group = entityManager.find(Group.class, id);
        entityManager.getTransaction().commit();
        entityManager.close();
        return Optional.ofNullable(group);
    }
    public List<Group> findAll() {
        EntityManager entityManager = getEntityManager();
        entityManager
                .getTransaction()
                .begin();
        List<Group> selectPFromGroup =
                entityManager
                        .createQuery("select p from Group p order by p.id", Group.class)
                        .getResultList();
        entityManager
                .getTransaction()
                .commit();

        entityManager
                .close();
        return selectPFromGroup;
    }

    public List<Room> getAvailableRooms(Days lessonDay, LocalTime start, LocalTime end, Integer groupId) {
        EntityManager entityManager = getEntityManager();

        String jpql = """
        SELECT r FROM Room r
        WHERE NOT EXISTS (
            SELECT g FROM Group g
            WHERE g.room = r
              AND g.lessonDays = :day
              AND g.id <> :groupId
              AND NOT (
                  :end <= g.startTime OR
                  :start >= g.endTime
              )
        )
        """;

        return entityManager.createQuery(jpql, Room.class)
                .setParameter("day", lessonDay)
                .setParameter("start", start)
                .setParameter("end", end)
                .setParameter("groupId", groupId == null ? -1 : groupId)
                .getResultList();
    }

    private GroupDAO() {
    }
    public static GroupDAO getInstance() {
        if (groupDAO == null) {
            groupDAO = new GroupDAO();
        }
        return groupDAO;
    }

    public void addStudentsByIds(Integer groupId, List<Integer> studentIds) {
        EntityManager em = getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        transaction.begin();
        Group group = em.find(Group.class, groupId);
        if (group == null) {
            throw new RuntimeException("Group not found with id: " + groupId);
        }
        int currentStudents = group.getStudents() != null ? group.getStudents().size() : 0;
        int roomCapacity = group.getRoom().getCapacity();
        int remainingCapacity = roomCapacity - currentStudents;
        List<Integer> newStudentIds = new ArrayList<>();
        for (Integer studentId : studentIds) {
            User student = em.find(User.class, studentId);
            if (student != null && student.getRole() == Role.STUDENT) {
                if (!group.getStudents().contains(student)) {
                    newStudentIds.add(studentId);
                }
            }
        }
        if (newStudentIds.size() > remainingCapacity) {
            throw new RuntimeException("Cannot add " + newStudentIds.size() +
                    " new students. Only " + remainingCapacity + " spots available in this group.");
        }
        for (Integer studentId : newStudentIds) {
            User student = em.find(User.class, studentId);
            if (student != null && student.getRole() == Role.STUDENT) {
                if (group.getStudents() == null) {
                    group.setStudents(new ArrayList<>());
                }
                group.getStudents().add(student);
            }
        }
        em.merge(group);
        transaction.commit();
        em.close();
    }
}
