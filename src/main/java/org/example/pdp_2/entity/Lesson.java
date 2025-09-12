package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.Data;

import javax.swing.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Entity
public class Lesson {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer lessonNumber;
    @ManyToOne
    private User teacher;
    @ManyToOne
    private Group group;
    private Integer moduleNumber;
    private LocalDate date;
    private Boolean isCompleted;
}
