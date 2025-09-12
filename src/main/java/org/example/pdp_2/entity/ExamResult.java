package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class ExamResult {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    private Exam exam;
    @ManyToOne
    private User student;
    private Integer studentMark;
}
