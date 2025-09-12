package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;
@Data
@Entity
public class Attendance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    private Lesson lesson;
    @OneToMany(mappedBy = "attendance")
    private List<Student_Attendance> attendances;
}
