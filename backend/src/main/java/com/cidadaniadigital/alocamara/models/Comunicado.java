package com.cidadaniadigital.alocamara.models;

import com.cidadaniadigital.alocamara.enums.EscopoComunicado;
import com.cidadaniadigital.alocamara.enums.TipoComunicado;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "comunicados")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Comunicado {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(columnDefinition = "uuid", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "camara_id", nullable = false)
    private Camara camara;

    /** Nullable — apenas para escopo VEREADOR */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vereador_id")
    private Vereador vereador;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private EscopoComunicado escopo;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TipoComunicado tipo;

    @Column(nullable = false)
    private String titulo;

    @Column(columnDefinition = "text", nullable = false)
    private String conteudo;

    private String imagemUrl;

    @Column(nullable = false)
    private Boolean publicado = false;

    private LocalDate dataPublicacao;

    @CreationTimestamp
    @Column(updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    private OffsetDateTime updatedAt;
}
