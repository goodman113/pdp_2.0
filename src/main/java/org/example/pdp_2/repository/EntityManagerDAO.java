package org.example.pdp_2.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class EntityManagerDAO {
    static EntityManagerFactory entityManagerFactory =null;
    public static EntityManager getEntityManager(){
        if(entityManagerFactory==null){
            entityManagerFactory = Persistence.createEntityManagerFactory("PDP");
        }
        return entityManagerFactory.createEntityManager();
    }
}
