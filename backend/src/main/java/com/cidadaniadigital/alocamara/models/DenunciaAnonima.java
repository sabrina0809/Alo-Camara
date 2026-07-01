package com.cidadaniadigital.alocamara.models;

import com.cidadaniadigital.alocamara.enums.CategoriaDenuncia;
import com.cidadaniadigital.alocamara.enums.StatusDenuncia;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "denuncias_anonimas")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DenunciaAnonima {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(columnDefinition = "uuid", updatable = false, nullable = false)
    private UUID id;

    @Column(unique = true, nullable = false, updatable = false)
    private String protocolo;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "camara_id", nullable = false)
    private Camara camara;

    @Enumerated(EnumType.STRING)
    private CategoriaDenuncia categoria;

    @Column(columnDefinition = "text", nullable = false)
    private String descricao;

    private String bairro;

    private String localReferencia;

    private String anexoUrl;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatusDenuncia status = StatusDenuncia.RECEBIDA;

    /** Nullable — jurídico responsável */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "atribuido_a")
    private UsuarioAdmin atribuidoA;

    @CreationTimestamp
    @Column(updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    private OffsetDateTime updatedAt;
}
