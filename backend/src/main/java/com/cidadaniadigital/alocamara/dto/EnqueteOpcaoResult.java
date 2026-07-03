package com.cidadaniadigital.alocamara.dto;

import java.util.UUID;

/** Opção de enquete com a contagem de votos apurada. */
public record EnqueteOpcaoResult(
        UUID id,
        String texto,
        Short ordem,
        long votos) {
}
