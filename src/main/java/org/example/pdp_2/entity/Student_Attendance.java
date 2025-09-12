package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Student_Attendance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    private User student;
    private Boolean isAttended;
    @ManyToOne
    private Attendance attendance;
}
