package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
@Entity
public class Exam {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    private Group group;
    private Integer moduleNumber;
    @OneToMany
    private List<ExamResult> examResults;
}
