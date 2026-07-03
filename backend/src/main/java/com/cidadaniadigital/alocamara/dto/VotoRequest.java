package com.cidadaniadigital.alocamara.dto;

import jakarta.validation.constraints.NotNull;
import java.util.UUID;

public record VotoRequest(
        @NotNull UUID cidadaoId,
        @NotNull UUID opcaoId) {
}
