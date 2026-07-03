package com.cidadaniadigital.alocamara.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import java.util.UUID;

public record AvaliacaoRequest(
        @NotNull UUID cidadaoId,
        @NotNull @Min(1) @Max(5) Short nota,
        String comentario) {
}
