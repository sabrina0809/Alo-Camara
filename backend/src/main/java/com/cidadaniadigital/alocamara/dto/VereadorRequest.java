package com.cidadaniadigital.alocamara.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * Payload de entrada para criar/atualizar um Vereador.
 */
public record VereadorRequest(
        @NotNull UUID camaraId,
        @NotBlank String nome,
        @NotBlank String slug,
        String partido,
        String regiao,
        String fotoUrl,
        String biografia,
        List<String> projetos,
        String emailGabinete,
        String telefoneGabinete,
        LocalDate mandatoInicio,
        LocalDate mandatoFim,
        Boolean ativo) {
}
