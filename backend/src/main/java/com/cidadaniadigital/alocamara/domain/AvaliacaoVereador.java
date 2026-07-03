package com.cidadaniadigital.alocamara.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.OffsetDateTime;
import java.util.UUID;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

/** Avaliação (nota 1-5) do cidadão sobre um vereador. Mapeia public.avaliacao_vereador. */
@Entity
@Table(name = "avaliacao_vereador")
@Getter
@Setter
@NoArgsConstructor
public class AvaliacaoVereador {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "vereador_id", nullable = false)
    private Vereador vereador;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cidadao_id", nullable = false)
    private Cidadao cidadao;

    @Column(name = "nota", nullable = false)
    private Short nota;

    @Column(name = "comentario")
    private String comentario;

    @Column(name = "moderado", nullable = false)
    private Boolean moderado = false;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;
}
