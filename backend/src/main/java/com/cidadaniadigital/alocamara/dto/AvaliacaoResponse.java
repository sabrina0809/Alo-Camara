package com.cidadaniadigital.alocamara.dto;

import java.time.OffsetDateTime;
import java.util.UUID;

public record AvaliacaoResponse(
        UUID id,
        UUID vereadorId,
        UUID cidadaoId,
        Short nota,
        String comentario,
        Boolean moderado,
        OffsetDateTime createdAt) {
}
