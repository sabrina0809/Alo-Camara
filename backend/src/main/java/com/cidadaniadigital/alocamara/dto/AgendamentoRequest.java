package com.cidadaniadigital.alocamara.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.time.OffsetDateTime;
import java.util.UUID;

public record AgendamentoRequest(
        @NotNull UUID cidadaoId,
        @NotNull UUID vereadorId,
        @NotBlank String assunto,
        String descricao,
        @NotNull OffsetDateTime dataSolicitada,
        String local) {
}
