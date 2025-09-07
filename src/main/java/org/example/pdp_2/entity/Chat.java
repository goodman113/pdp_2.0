package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
@Data
@Entity
public class Chat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    private User fromUser;
    @ManyToOne
    private User toUser;
    private String text;
    private LocalDateTime date;
}
