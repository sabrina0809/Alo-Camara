package com.cidadaniadigital.alocamara.dto;

import com.cidadaniadigital.alocamara.domain.enums.EnqueteStatus;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

public record EnqueteResponse(
        UUID id,
        UUID camaraId,
        UUID vereadorId,
        String titulo,
        String descricao,
        EnqueteStatus status,
        OffsetDateTime dataInicio,
        OffsetDateTime dataFim,
        List<EnqueteOpcaoResult> opcoes) {
}
