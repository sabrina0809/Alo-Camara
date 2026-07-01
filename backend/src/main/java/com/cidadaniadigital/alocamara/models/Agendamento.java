package com.cidadaniadigital.alocamara.models;

import com.cidadaniadigital.alocamara.enums.StatusAgendamento;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "agendamentos")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Agendamento {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(columnDefinition = "uuid", updatable = false, nullable = false)
    private UUID id;

    @Column(unique = true, nullable = false, updatable = false)
    private String protocolo;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cidadao_id", nullable = false)
    private Cidadao cidadao;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "vereador_id", nullable = false)
    private Vereador vereador;

    @Column(nullable = false)
    private String assunto;

    @Column(columnDefinition = "text")
    private String descricao;

    @Column(nullable = false)
    private OffsetDateTime dataSolicitacao;

    private OffsetDateTime dataConfirmada;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatusAgendamento status = StatusAgendamento.SOLICITADO;

    private String local;

    @CreationTimestamp
    @Column(updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    private OffsetDateTime updatedAt;
}
