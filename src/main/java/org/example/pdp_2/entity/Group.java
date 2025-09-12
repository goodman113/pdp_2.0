package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.*;
import org.example.pdp_2.entity.enums.Days;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Getter
@Setter

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "groups")
public class Group {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String groupName;
    @ManyToOne
    private User teacher;
    @ManyToOne
    private Room room;
    @ManyToMany
    private List<User> students;
    private Integer moduleNumber;
    private Boolean isActive;
    private LocalTime startTime;
    private LocalTime endTime;
    @Enumerated(EnumType.STRING)
    private Days lessonDays;
}
