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

/** Resposta do admin a uma manifestação. Mapeia public.resposta_manifestacao (só created_at). */
@Entity
@Table(name = "resposta_manifestacao")
@Getter
@Setter
@NoArgsConstructor
public class RespostaManifestacao {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "manifestacao_id", nullable = false)
    private Manifestacao manifestacao;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "autor_admin_id", nullable = false)
    private UsuarioAdmin autorAdmin;

    @Column(name = "mensagem", nullable = false)
    private String mensagem;

    @Column(name = "visivel_cidadao", nullable = false)
    private Boolean visivelCidadao = true;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;
}
