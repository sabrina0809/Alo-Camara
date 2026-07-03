package com.cidadaniadigital.alocamara.dto;

import com.cidadaniadigital.alocamara.domain.enums.AgendamentoStatus;
import java.time.OffsetDateTime;
import java.util.UUID;

public record AgendamentoResponse(
        UUID id,
        String protocolo,
        UUID cidadaoId,
        UUID vereadorId,
        String assunto,
        String descricao,
        OffsetDateTime dataSolicitada,
        OffsetDateTime dataConfirmada,
        AgendamentoStatus status,
        String local,
        OffsetDateTime createdAt,
        OffsetDateTime updatedAt) {
}
