package com.cidadaniadigital.alocamara.service;

import com.cidadaniadigital.alocamara.domain.Comunicado;
import com.cidadaniadigital.alocamara.dto.ComunicadoResponse;
import com.cidadaniadigital.alocamara.repository.ComunicadoRepository;
import java.util.List;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ComunicadoService {

    private final ComunicadoRepository repo;

    public ComunicadoService(ComunicadoRepository repo) {
        this.repo = repo;
    }

    @Transactional(readOnly = true)
    public List<ComunicadoResponse> listar(UUID camaraId, Boolean apenasPublicados) {
        List<Comunicado> lista;
        if (Boolean.TRUE.equals(apenasPublicados)) {
            lista = repo.findByPublicadoTrueOrderByDataPublicacaoDesc();
        } else if (camaraId != null) {
            lista = repo.findByCamaraId(camaraId);
        } else {
            lista = repo.findAll();
        }
        return lista.stream().map(this::toResponse).toList();
    }

    private ComunicadoResponse toResponse(Comunicado c) {
        return new ComunicadoResponse(
                c.getId(),
                c.getCamara() != null ? c.getCamara().getId() : null,
                c.getVereador() != null ? c.getVereador().getId() : null,
                c.getEscopo(), c.getTipo(), c.getTitulo(), c.getConteudo(),
                c.getImagemUrl(), c.getPublicado(), c.getDataPublicacao(),
                c.getCreatedAt(), c.getUpdatedAt());
    }
}
