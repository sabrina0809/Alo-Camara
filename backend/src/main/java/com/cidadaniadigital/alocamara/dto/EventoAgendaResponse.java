package com.cidadaniadigital.alocamara.dto;

import com.cidadaniadigital.alocamara.domain.enums.EventoCategoria;
import com.cidadaniadigital.alocamara.domain.enums.EventoStatus;
import java.time.OffsetDateTime;
import java.util.UUID;

public record EventoAgendaResponse(
        UUID id,
        UUID camaraId,
        String titulo,
        String descricao,
        EventoCategoria categoria,
        OffsetDateTime dataHora,
        String local,
        String linkTransmissao,
        EventoStatus status,
        OffsetDateTime createdAt,
        OffsetDateTime updatedAt) {
}
