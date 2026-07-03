package com.cidadaniadigital.alocamara.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.util.UUID;

public record DenunciaRequest(
        @NotNull UUID camaraId,
        String categoria,
        @NotBlank String descricao,
        String bairro,
        String localReferencia,
        String anexoUrl) {
}
