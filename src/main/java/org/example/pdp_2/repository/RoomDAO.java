package org.example.pdp_2.repository;

import jakarta.persistence.EntityManager;
import org.example.pdp_2.entity.Room;

import java.util.Optional;

import static org.example.pdp_2.repository.EntityManagerDAO.getEntityManager;

public class RoomDAO {
    public Optional<Room> findById(Integer id) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        Room room = entityManager.find(Room.class, id);
        entityManager.getTransaction().commit();
        entityManager.close();
        return Optional.ofNullable(room);
    }

    private RoomDAO() {
    }

    private static RoomDAO roomDAO = null;

    public static RoomDAO getInstance() {
        if (roomDAO == null) {
            roomDAO = new RoomDAO();
        }
        return roomDAO;
    }
}
