package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.example.pdp_2.entity.enums.Days;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Data
@Entity
public class Group {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String groupName;
    @ManyToOne
    private User teacher;
    @ManyToOne
    private Room room;
    @OneToMany
    private List<User> students;
    private Integer moduleNumber;
    private Boolean isActive;
    private LocalTime startTime;
    private LocalTime endTime;
    private Days lessonDays;
}
