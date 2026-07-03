package com.cidadaniadigital.alocamara.domain;

import com.cidadaniadigital.alocamara.domain.enums.ComunicadoEscopo;
import com.cidadaniadigital.alocamara.domain.enums.ComunicadoTipo;
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
import java.time.OffsetDateTime;
import java.util.UUID;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.type.SqlTypes;

/** Comunicado institucional ou de vereador. Mapeia public.comunicado. */
@Entity
@Table(name = "comunicado")
@Getter
@Setter
@NoArgsConstructor
public class Comunicado {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "camara_id", nullable = false)
    private Camara camara;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vereador_id")
    private Vereador vereador;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "escopo", nullable = false, columnDefinition = "comunicado_escopo_enum")
    private ComunicadoEscopo escopo;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "tipo", nullable = false, columnDefinition = "comunicado_tipo_enum")
    private ComunicadoTipo tipo;

    @Column(name = "titulo", nullable = false)
    private String titulo;

    @Column(name = "conteudo", nullable = false)
    private String conteudo;

    @Column(name = "imagem_url")
    private String imagemUrl;

    @Column(name = "publicado", nullable = false)
    private Boolean publicado = false;

    @Column(name = "data_publicacao")
    private OffsetDateTime dataPublicacao;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;
}
