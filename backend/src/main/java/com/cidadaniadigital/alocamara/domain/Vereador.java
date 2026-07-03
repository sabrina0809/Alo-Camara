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
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.type.SqlTypes;

/**
 * Vereador vinculado a uma Câmara.
 * Mapeia a tabela public.vereador do Supabase.
 */
@Entity
@Table(name = "vereador")
@Getter
@Setter
@NoArgsConstructor
public class Vereador {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "camara_id", nullable = false)
    private Camara camara;

    @Column(name = "nome", nullable = false)
    private String nome;

    @Column(name = "slug", nullable = false, unique = true)
    private String slug;

    @Column(name = "partido", length = 20)
    private String partido;

    @Column(name = "regiao")
    private String regiao;

    @Column(name = "foto_url")
    private String fotoUrl;

    @Column(name = "biografia")
    private String biografia;

    // text[] no banco → array de String
    @JdbcTypeCode(SqlTypes.ARRAY)
    @Column(name = "projetos", columnDefinition = "text[]")
    private List<String> projetos;

    @Column(name = "email_gabinete")
    private String emailGabinete;

    @Column(name = "telefone_gabinete", length = 20)
    private String telefoneGabinete;

    @Column(name = "mandato_inicio")
    private LocalDate mandatoInicio;

    @Column(name = "mandato_fim")
    private LocalDate mandatoFim;

    @Column(name = "ativo", nullable = false)
    private Boolean ativo = true;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;
}
