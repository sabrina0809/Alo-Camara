package com.cidadaniadigital.alocamara.dto;

import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoCategoria;
import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoPrioridade;
import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoStatus;
import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoTipo;
import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

public record ManifestacaoResponse(
        UUID id,
        String protocolo,
        UUID cidadaoId,
        UUID vereadorId,
        ManifestacaoTipo tipo,
        ManifestacaoCategoria categoria,
        String bairro,
        String descricao,
        String anexoUrl,
        BigDecimal latitude,
        BigDecimal longitude,
        ManifestacaoStatus status,
        ManifestacaoPrioridade prioridade,
        OffsetDateTime createdAt,
        OffsetDateTime updatedAt) {
}
