package com.cidadaniadigital.alocamara.domain;

import com.cidadaniadigital.alocamara.domain.enums.DenunciaStatus;
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

/** Denúncia anônima (sem vínculo ao cidadão). Mapeia public.denuncia_anonima. */
@Entity
@Table(name = "denuncia_anonima")
@Getter
@Setter
@NoArgsConstructor
public class DenunciaAnonima {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    private UUID id;

    @Column(name = "protocolo", nullable = false, unique = true)
    private String protocolo;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "camara_id", nullable = false)
    private Camara camara;

    @Column(name = "categoria")
    private String categoria;

    @Column(name = "descricao", nullable = false)
    private String descricao;

    @Column(name = "bairro")
    private String bairro;

    @Column(name = "local_referencia")
    private String localReferencia;

    @Column(name = "anexo_url")
    private String anexoUrl;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "status", nullable = false, columnDefinition = "denuncia_status_enum")
    private DenunciaStatus status = DenunciaStatus.recebida;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "atribuido_a")
    private UsuarioAdmin atribuidoA;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;
}
