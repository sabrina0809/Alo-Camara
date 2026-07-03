package com.cidadaniadigital.alocamara.service;

import com.cidadaniadigital.alocamara.domain.Camara;
import com.cidadaniadigital.alocamara.domain.DenunciaAnonima;
import com.cidadaniadigital.alocamara.dto.DenunciaRequest;
import com.cidadaniadigital.alocamara.dto.DenunciaResponse;
import com.cidadaniadigital.alocamara.repository.CamaraRepository;
import com.cidadaniadigital.alocamara.repository.DenunciaAnonimaRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DenunciaService {

    private final DenunciaAnonimaRepository repo;
    private final CamaraRepository camaraRepo;

    public DenunciaService(DenunciaAnonimaRepository repo, CamaraRepository camaraRepo) {
        this.repo = repo;
        this.camaraRepo = camaraRepo;
    }

    @Transactional
    public DenunciaResponse criar(DenunciaRequest req) {
        Camara camara = camaraRepo.findById(req.camaraId())
                .orElseThrow(() -> new EntityNotFoundException("Câmara não encontrada: " + req.camaraId()));
        DenunciaAnonima d = new DenunciaAnonima();
        d.setProtocolo("DEN-" + System.currentTimeMillis());
        d.setCamara(camara);
        d.setCategoria(req.categoria());
        d.setDescricao(req.descricao());
        d.setBairro(req.bairro());
        d.setLocalReferencia(req.localReferencia());
        d.setAnexoUrl(req.anexoUrl());
        return toResponse(repo.save(d));
    }

    @Transactional(readOnly = true)
    public DenunciaResponse buscarPorProtocolo(String protocolo) {
        return repo.findByProtocolo(protocolo).map(this::toResponse)
                .orElseThrow(() -> new EntityNotFoundException("Denúncia não encontrada: " + protocolo));
    }

    private DenunciaResponse toResponse(DenunciaAnonima d) {
        return new DenunciaResponse(
                d.getId(), d.getProtocolo(),
                d.getCamara() != null ? d.getCamara().getId() : null,
                d.getCategoria(), d.getDescricao(), d.getBairro(),
                d.getLocalReferencia(), d.getAnexoUrl(), d.getStatus(),
                d.getCreatedAt(), d.getUpdatedAt());
    }
}
