package com.cidadaniadigital.alocamara.dto;

import com.cidadaniadigital.alocamara.domain.enums.EnqueteStatus;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

public record EnqueteRequest(
        @NotNull UUID camaraId,
        UUID vereadorId,
        @NotBlank String titulo,
        String descricao,
        EnqueteStatus status,
        OffsetDateTime dataInicio,
        OffsetDateTime dataFim,
        @NotEmpty List<String> opcoes) {
}
