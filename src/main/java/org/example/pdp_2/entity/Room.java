package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
@Entity
public class Room {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String number;
    private Integer capacity;
    @OneToMany(mappedBy = "room")
    private List<Group> groups;
}
