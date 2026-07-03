package com.cidadaniadigital.alocamara.dto;

import com.cidadaniadigital.alocamara.domain.enums.ComunicadoEscopo;
import com.cidadaniadigital.alocamara.domain.enums.ComunicadoTipo;
import java.time.OffsetDateTime;
import java.util.UUID;

public record ComunicadoResponse(
        UUID id,
        UUID camaraId,
        UUID vereadorId,
        ComunicadoEscopo escopo,
        ComunicadoTipo tipo,
        String titulo,
        String conteudo,
        String imagemUrl,
        Boolean publicado,
        OffsetDateTime dataPublicacao,
        OffsetDateTime createdAt,
        OffsetDateTime updatedAt) {
}
