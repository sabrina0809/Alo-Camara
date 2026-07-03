package com.cidadaniadigital.alocamara.dto;

import com.cidadaniadigital.alocamara.domain.enums.DenunciaStatus;
import java.time.OffsetDateTime;
import java.util.UUID;

public record DenunciaResponse(
        UUID id,
        String protocolo,
        UUID camaraId,
        String categoria,
        String descricao,
        String bairro,
        String localReferencia,
        String anexoUrl,
        DenunciaStatus status,
        OffsetDateTime createdAt,
        OffsetDateTime updatedAt) {
}
