package com.cidadaniadigital.alocamara.models;

import com.cidadaniadigital.alocamara.enums.CategoriaManifestacao;
import com.cidadaniadigital.alocamara.enums.PrioridadeManifestacao;
import com.cidadaniadigital.alocamara.enums.StatusManifestacao;
import com.cidadaniadigital.alocamara.enums.TipoManifestacao;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "manifestacoes")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Manifestacao {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(columnDefinition = "uuid", updatable = false, nullable = false)
    private UUID id;

    @Column(unique = true, nullable = false, updatable = false)
    private String protocolo;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cidadao_id", nullable = false)
    private Cidadao cidadao;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vereador_id")
    private Vereador vereador;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TipoManifestacao tipo;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CategoriaManifestacao categoria;

    private String bairro;

    @Column(columnDefinition = "text", nullable = false)
    private String descricao;

    private String anexoUrl;

    private Double latitude;

    private Double longitude;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatusManifestacao status = StatusManifestacao.RECEBIDA;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PrioridadeManifestacao prioridade = PrioridadeManifestacao.BAIXA;

    @CreationTimestamp
    @Column(updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    private OffsetDateTime updatedAt;
}
