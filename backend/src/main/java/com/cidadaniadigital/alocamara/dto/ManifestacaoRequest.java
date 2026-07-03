package com.cidadaniadigital.alocamara.dto;

import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoCategoria;
import com.cidadaniadigital.alocamara.domain.enums.ManifestacaoTipo;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.UUID;

public record ManifestacaoRequest(
        @NotNull UUID cidadaoId,
        @NotNull UUID vereadorId,
        @NotNull ManifestacaoTipo tipo,
        @NotNull ManifestacaoCategoria categoria,
        String bairro,
        @NotBlank String descricao,
        String anexoUrl,
        BigDecimal latitude,
        BigDecimal longitude) {
}
