package com.cidadaniadigital.alocamara.models;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.security.AuthProvider;
import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "cidadaos")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Cidadao {

    @Id
    @Column(columnDefinition = "uuid", updatable = false, nullable = false)
    private UUID id;

    @Column(nullable = false)
    private String nome;

    @Column(unique = true)
    private String email;

    private String telefone;

    @Column(unique = true)
    private String cpf;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private AuthProvider authProvider;

    private String passwordHash;

    private String fotoUrl;

    @CreationTimestamp
    @Column(updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    private OffsetDateTime updatedAt;
}
