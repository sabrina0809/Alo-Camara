package com.cidadaniadigital.alocamara.domain;

import com.cidadaniadigital.alocamara.domain.enums.AuthProvider;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
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
 * Cidadão usuário do app.
 * Mapeia a tabela public.cidadao — inclui email (citext) e auth_provider (enum PG).
 */
@Entity
@Table(name = "cidadao")
@Getter
@Setter
@NoArgsConstructor
public class Cidadao {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    private UUID id;

    @Column(name = "nome", nullable = false)
    private String nome;

    // citext no banco (case-insensitive) → tratado como texto
    @JdbcTypeCode(SqlTypes.VARCHAR)
    @Column(name = "email", nullable = false, unique = true, columnDefinition = "citext")
    private String email;

    @Column(name = "telefone", length = 20)
    private String telefone;

    @Column(name = "cpf", length = 14, unique = true)
    private String cpf;

    // enum PG auth_provider_enum
    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "auth_provider", nullable = false, columnDefinition = "auth_provider_enum")
    private AuthProvider authProvider = AuthProvider.email;

    @Column(name = "password_hash")
    private String passwordHash;

    @Column(name = "foto_url")
    private String fotoUrl;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;
}
