package com.cidadaniadigital.alocamara.models;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "respostas_manifestacao")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class RespostaManifestacao {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(columnDefinition = "uuid", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "manifestacao_id", nullable = false)
    private Manifestacao manifestacao;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "autor_admin_id", nullable = false)
    private UsuarioAdmin autorAdmin;

    @Column(columnDefinition = "text", nullable = false)
    private String mensagem;

    @Column(nullable = false)
    private Boolean visivelCidadao = true;

    @CreationTimestamp
    @Column(updatable = false)
    private OffsetDateTime createdAt;
}
