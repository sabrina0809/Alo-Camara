package com.cidadaniadigital.alocamara.dto;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Representação de saída de um Vereador para a API REST.
 * Campos alinhados com o que o front (tela de vereadores) consome.
 */
public record VereadorResponse(
        UUID id,
        UUID camaraId,
        String nome,
        String slug,
        String partido,
        String regiao,
        String fotoUrl,
        String biografia,
        List<String> projetos,
        String emailGabinete,
        String telefoneGabinete,
        LocalDate mandatoInicio,
        LocalDate mandatoFim,
        Boolean ativo,
        OffsetDateTime createdAt,
        OffsetDateTime updatedAt) {
}
