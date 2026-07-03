package com.cidadaniadigital.alocamara.domain;

import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoCategoria;
import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoPrioridade;
import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoStatus;
import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoTipo;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.type.SqlTypes;

/** Manifestação do cidadão (solicitação/reclamação/sugestão/elogio). Mapeia public.manifestacao. */
@Entity
@Table(name = "manifestacao")
@Getter
@Setter
@NoArgsConstructor
public class Manifestacao {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    private UUID id;

    @Column(name = "protocolo", nullable = false, unique = true)
    private String protocolo;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cidadao_id", nullable = false)
    private Cidadao cidadao;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "vereador_id", nullable = false)
    private Vereador vereador;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "tipo", nullable = false, columnDefinition = "manifestacao_tipo_enum")
    private ManifestacaoTipo tipo;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "categoria", nullable = false, columnDefinition = "manifestacao_categoria_enum")
    private ManifestacaoCategoria categoria;

    @Column(name = "bairro")
    private String bairro;

    @Column(name = "descricao", nullable = false)
    private String descricao;

    @Column(name = "anexo_url")
    private String anexoUrl;

    @Column(name = "latitude")
    private BigDecimal latitude;

    @Column(name = "longitude")
    private BigDecimal longitude;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "status", nullable = false, columnDefinition = "manifestacao_status_enum")
    private ManifestacaoStatus status = ManifestacaoStatus.recebida;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "prioridade", nullable = false, columnDefinition = "manifestacao_prioridade_enum")
    private ManifestacaoPrioridade prioridade = ManifestacaoPrioridade.media;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;
}
