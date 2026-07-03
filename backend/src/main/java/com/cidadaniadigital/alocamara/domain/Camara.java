package com.cidadaniadigital.alocamara.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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

/**
 * Câmara Municipal — raiz multi-tenant do sistema.
 * Mapeia a tabela public.camara do Supabase.
 */
@Entity
@Table(name = "camara")
@Getter
@Setter
@NoArgsConstructor
public class Camara {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    private UUID id;

    @Column(name = "nome", nullable = false)
    private String nome;

    @Column(name = "municipio", nullable = false)
    private String municipio;

    // character(2) no banco → força o tipo CHAR para o validate bater
    @JdbcTypeCode(SqlTypes.CHAR)
    @Column(name = "uf", nullable = false, length = 2)
    private String uf;

    @Column(name = "logo_url")
    private String logoUrl;

    @Column(name = "endereco")
    private String endereco;

    @Column(name = "email_juridico")
    private String emailJuridico;

    @Column(name = "contato_accom")
    private String contatoAccom;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;
}
