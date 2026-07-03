package com.cidadaniadigital.alocamara.mapper;

import com.cidadaniadigital.alocamara.domain.Vereador;
import com.cidadaniadigital.alocamara.dto.VereadorResponse;

/**
 * Conversão entre a entidade Vereador e seus DTOs.
 */
public final class VereadorMapper {

    private VereadorMapper() {
    }

    public static VereadorResponse toResponse(Vereador v) {
        return new VereadorResponse(
                v.getId(),
                v.getCamara() != null ? v.getCamara().getId() : null,
                v.getNome(),
                v.getSlug(),
                v.getPartido(),
                v.getRegiao(),
                v.getFotoUrl(),
                v.getBiografia(),
                v.getProjetos(),
                v.getEmailGabinete(),
                v.getTelefoneGabinete(),
                v.getMandatoInicio(),
                v.getMandatoFim(),
                v.getAtivo(),
                v.getCreatedAt(),
                v.getUpdatedAt());
    }
}
