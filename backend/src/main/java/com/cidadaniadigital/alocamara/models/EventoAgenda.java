package com.cidadaniadigital.alocamara.models;

import com.cidadaniadigital.alocamara.enums.CategoriaEvento;
import com.cidadaniadigital.alocamara.enums.StatusEvento;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "eventos_agenda")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class EventoAgenda {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(columnDefinition = "uuid", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "camara_id", nullable = false)
    private Camara camara;

    @Column(nullable = false)
    private String titulo;

    @Column(columnDefinition = "text")
    private String descricao;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CategoriaEvento categoria;

    @Column(nullable = false)
    private OffsetDateTime dataHora;

    private String local;

    private String linkTransmissao;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatusEvento status = StatusEvento.AGENDADA;

    @CreationTimestamp
    @Column(updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    private OffsetDateTime updatedAt;
}
