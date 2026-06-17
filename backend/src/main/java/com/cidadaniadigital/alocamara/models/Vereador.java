package com.cidadaniadigital.alocamara.models;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "vereadores")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Vereador {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(columnDefinition = "uuid", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "camara_id", nullable = false)
    private Camara camara;

    @Column(nullable = false)
    private String nome;

    @Column(unique = true, nullable = false)
    private String slug;

    private String partido;

    @Column(columnDefinition = "text")
    private String regras;

    private String fotoUrl;

    @Column(columnDefinition = "text")
    private String biografia;

    @Column(columnDefinition = "text")
    private String projetos;

    private String emailGabinete;

    private String telefoneGabinete;

    private LocalDate mandatoInicio;

    private LocalDate mandatoFim;

    @Column(nullable = false)
    private Boolean ativo = true;

    @CreationTimestamp
    @Column(updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    private OffsetDateTime updatedAt;
}
