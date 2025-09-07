package org.example.pdp_2.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.example.pdp_2.entity.enums.Role;

@Entity
@Table(name = "users")
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String name;
    private String surname;
    private String phoneNumber;
    private String password;
    @Enumerated(EnumType.STRING)
    private Role role;
    private Boolean is_Active;
}
