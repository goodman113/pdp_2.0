package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Invoice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String invoiceNumber;
    @ManyToOne
    private User student;
    private double amount;
    private Boolean is_Paid;
}
